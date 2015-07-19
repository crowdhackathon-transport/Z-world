#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import Voronoi
import MySQLdb as mdb
import ddbscan


def voronoi_finite_polygons_2d(vor, radius=None):
    if vor.points.shape[1] != 2:
        raise ValueError("Requires 2D input")

    new_regions = []
    new_vertices = vor.vertices.tolist()

    center = vor.points.mean(axis=0)
    if radius is None:
        radius = vor.points.ptp().max()

    # Construct a map containing all ridges for a given point
    all_ridges = {}
    for (p1, p2), (v1, v2) in zip(vor.ridge_points, vor.ridge_vertices):
        all_ridges.setdefault(p1, []).append((p2, v1, v2))
        all_ridges.setdefault(p2, []).append((p1, v1, v2))

    # Reconstruct infinite regions
    for p1, region in enumerate(vor.point_region):
        vertices = vor.regions[region]

        if all(v >= 0 for v in vertices):
            # finite region
            new_regions.append(vertices)
            continue

        # reconstruct a non-finite region
        ridges = all_ridges[p1]
        new_region = [v for v in vertices if v >= 0]

        for p2, v1, v2 in ridges:
            if v2 < 0:
                v1, v2 = v2, v1
            if v1 >= 0:
                # finite ridge: already in the region
                continue

            # Compute the missing endpoint of an infinite ridge
            t = vor.points[p2] - vor.points[p1]  # tangent
            t /= np.linalg.norm(t)
            n = np.array([-t[1], t[0]])  # normal
            midpoint = vor.points[[p1, p2]].mean(axis=0)
            direction = np.sign(np.dot(midpoint - center, n)) * n
            far_point = vor.vertices[v2] + direction * radius
            new_region.append(len(new_vertices))
            new_vertices.append(far_point.tolist())
        # sort region counterclockwise
        vs = np.asarray([new_vertices[v] for v in new_region])
        c = vs.mean(axis=0)
        angles = np.arctan2(vs[:, 1] - c[1], vs[:, 0] - c[0])
        new_region = np.array(new_region)[np.argsort(angles)]
        # finish
        new_regions.append(new_region.tolist())

    return new_regions, np.asarray(new_vertices)


#######################################################################################################################

con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8",
                  init_command='SET NAMES UTF8')

cur = con.cursor(mdb.cursors.DictCursor)
cur.execute("SET character_set_connection=utf8mb4;")
cur.execute("SELECT * FROM `population_point` p WHERE `location_lat`!='0' AND `location_lng`!='0' AND p.municipality!='ΑΙΓΙΝΑΣ' AND p.municipality!='ΚΥΘΗΡΩΝ' AND p.municipality!='ΠΟΡΟΥ' AND p.municipality!='ΤΡΟΙΖΗΝΙΑΣ-ΜΕΘΑΝΩΝ' AND p.municipality!='ΥΔΡΑΣ' AND p.municipality!='ΣΠΕΤΣΩΝ' AND p.municipality!='ΑΓΚΙΣΤΡΙΟΥ' AND p.municipality!='ΣΑΛΑΜΙΝΑΣ' AND p.municipality!='ΩΡΩΠΟΥ' AND p.municipality!='ΜΕΓΑΡΕΩΝ' AND p.municipality!='ΜΑΝΔΡΑΣ - ΕΙΔΥΛΛΙΑΣ' AND p.municipality!='ΜΑΡΑΘΩΝΟΣ';")

rows = cur.fetchall()
arr = []
arr_ids = []
arr_population = []
for row in rows:
    # print '{ "type": "Feature", "id": '+str(pos)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(row["location_lat"])+' , '+str(row["location_lng"])+'] } },'
    arr.append([float(row["location_lat"]), float(row["location_lng"])])
    arr_ids.append(row["id"])
    arr_population.append(row["ctizens_number"])

print arr
print "************* DBSCAN *************"
scan = ddbscan.DDBSCAN(.005, 1)
for point in arr:
    scan.add_point(point=point, count=1, desc="")
# Compute clusters
scan.compute()


print 'Clusters found and its members points index:'
cluster_number = 0
for cluster in scan.clusters:
    print '=== Cluster %d ===' % cluster_number
    print 'Cluster points index: %s' % list(cluster)
    cluster_number += 1

cluster_number = 0
point_arr = []
for cluster in scan.clusters:
    cluster_number += 1
    lat_sum = 0.0
    lng_sum = 0.0
    for cl in list(cluster):
        lat_sum += float(arr[cl][0])
        lng_sum += float(arr[cl][1])
    lat = lat_sum / len(list(cluster))
    lng = lng_sum / len(list(cluster))
    point_arr.append([lat, lng])
    # print '{ "type": "Feature", "id": '+str(cluster_number)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(lat)+' , '+str(lng)+'] } },'

p = np.array(point_arr)
vor = Voronoi(p)

# plot
regions, vertices = voronoi_finite_polygons_2d(vor)

print "--"
print regions
print "--"
print vertices

data_polygons = []
counter = 0
for region in regions:
    data = {"type": "Feature", "properties": {"id": str(counter)}, "point_list": list(scan.clusters[counter])}

    point_list = []
    population_sum = 0
    for point in list(scan.clusters[counter]):
        population_sum += arr_population[counter]
        point_list.append(arr_ids[point])
    data["center_point"]=point_arr[counter]
    data["population_sum"]=population_sum
    data["point_list"] = point_list
    data_geometry = {"type": "Polygon"}

    data_polygons.append(data)
    print "polygon:", counter
    print "center:", point_arr[counter]
    data_coordinates = []
    for vert in vertices[region]:
        data_coordinates.append([vert[1], vert[0]])
        print vert[0], ", ", vert[1]
    counter += 1
    data_geometry["coordinates"] = [data_coordinates]
    data["geometry"] = data_geometry

json_data = json.dumps(data_polygons)

print json_data


# insert to db
# counter = 0
# for region in regions:
#     point_list = []
#     population_sum = 0
#     poly_str = ''
#     for point in list(scan.clusters[counter]):
#         population_sum += arr_population[counter]
#         point_list.append(arr_ids[point])
#     for vert in vertices[region]:
#         poly_str+=str(vert[0]) + " " + str(vert[1]) + ","
#     poly_str += str(vertices[region][0][0]) + " " + str(vertices[region][0][1])
#     cur = con.cursor()
#     cur.execute("INSERT INTO `polygon`(`id`, `lat`, `lng`, `population_sum`, `poly`) VALUES ("+str(counter+1)+","+str(point_arr[counter][0])+","+str(point_arr[counter][1])+","+str(population_sum)+",PolyFromText('POLYGON(("+poly_str+"))'))")
#     con.commit()
#     for point in list(scan.clusters[counter]):
#         cur = con.cursor()
#         cur.execute("INSERT INTO `polygon_points`(`polygon_id`, `population_point_id`) VALUES ("+str(counter+1)+","+str(arr_ids[point])+")")
#         con.commit()


# colorize
for region in regions:
    polygon = vertices[region]
    plt.fill(*zip(*polygon), alpha=0.4)

plt.plot(p[:, 0], p[:, 1], 'ko')
plt.xlim(vor.min_bound[0] - 0.1, vor.max_bound[0] + 0.1)
plt.ylim(vor.min_bound[1] - 0.1, vor.max_bound[1] + 0.1)

plt.show()