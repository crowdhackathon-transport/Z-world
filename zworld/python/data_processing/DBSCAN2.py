#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import numpy as np
import MySQLdb as mdb

import ddbscan


import matplotlib.tri
import matplotlib.pyplot as plt
import sys


def circumcircle2(T):
    P1, P2, P3 = T[:, 0], T[:, 1], T[:, 2]
    b = P2 - P1
    c = P3 - P1
    d = 2 * (b[:, 0] * c[:, 1] - b[:, 1] * c[:, 0])
    center_x = (c[:, 1] * (np.square(b[:, 0]) + np.square(b[:, 1])) - b[:, 1] * (
        np.square(c[:, 0]) + np.square(c[:, 1]))) / d + P1[:, 0]
    center_y = (b[:, 0] * (np.square(c[:, 0]) + np.square(c[:, 1])) - c[:, 0] * (
        np.square(b[:, 0]) + np.square(b[:, 1]))) / d + P1[:, 1]
    return np.array((center_x, center_y)).T


def check_outside(point, bbox):
    point = np.round(point, 4)
    return point[0] < bbox[0] or point[0] > bbox[2] or point[1] < bbox[1] or point[1] > bbox[3]


def move_point(start, end, bbox):
    vector = end - start
    c = calc_shift(start, vector, bbox)
    if 0 < c < 1:
        start = start + c * vector
        return start


def calc_shift(point, vector, bbox):
    c = sys.float_info.max
    for l, m in enumerate(bbox):
        a = (float(m) - point[l % 2]) / vector[l % 2]
        if a > 0 and not check_outside(point + a * vector, bbox):
            if abs(a) < abs(c):
                c = a
    return c if c < sys.float_info.max else None


def voronoi2(P, bbox=None):
    if not isinstance(P, np.ndarray):
        P = np.array(P)
    if not bbox:
        xmin = P[:, 0].min()
        xmax = P[:, 0].max()
        ymin = P[:, 1].min()
        ymax = P[:, 1].max()
        xrange = (xmax - xmin) * 0.3333333
        yrange = (ymax - ymin) * 0.3333333
        bbox = (xmin - xrange, ymin - yrange, xmax + xrange, ymax + yrange)
    bbox = np.round(bbox, 4)

    D = matplotlib.tri.Triangulation(P[:, 0], P[:, 1])
    T = D.triangles
    n = T.shape[0]
    C = circumcircle2(P[T])

    segments = []
    for i in range(n):
        for j in range(3):
            k = D.neighbors[i][j]
            if k != -1:
                # cut segment to part in bbox
                start, end = C[i], C[k]
                if check_outside(start, bbox):
                    start = move_point(start, end, bbox)
                    if start is None:
                        continue
                if check_outside(end, bbox):
                    end = move_point(end, start, bbox)
                    if end is None:
                        continue
                segments.append([start, end])
            else:
                # ignore center outside of bbox
                if check_outside(C[i], bbox):
                    continue
                first, second, third = P[T[i, j]], P[T[i, (j + 1) % 3]], P[T[i, (j + 2) % 3]]
                edge = np.array([first, second])
                vector = np.array([[0, 1], [-1, 0]]).dot(edge[1] - edge[0])
                line = lambda p: (p[0] - first[0]) * (second[1] - first[1]) / (second[0] - first[0]) - p[1] + first[1]
                orientation = np.sign(line(third)) * np.sign(line(first + vector))
                if orientation > 0:
                    vector = -orientation * vector
                c = calc_shift(C[i], vector, bbox)
                if c is not None:
                    segments.append([C[i], C[i] + c * vector])
    return segments

########################################################################################################################



con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8",
                  init_command='SET NAMES UTF8')


cur = con.cursor(mdb.cursors.DictCursor)
cur.execute("SET character_set_connection=utf8mb4;")
cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' GROUP BY location_lat, location_lng;")

rows = cur.fetchall()
arr = []
pos = 0
for row in rows:
    pos += 1
    # print '{ "type": "Feature", "id": '+str(pos)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(row["location_lat"])+' , '+str(row["location_lng"])+'] } },'
    arr.append([float(row["location_lat"]), float(row["location_lng"])])
# arr = np.random.randn(500000*2).reshape((500000, 2))
print "========================================================"
print "========================================================"
print arr
print "************* DBSCAN *************"
scan = ddbscan.DDBSCAN(.005, 1)
for point in arr:
    scan.add_point(point=point, count=1, desc="")

# Compute clusters
scan.compute()

# print 'Clusters found and its members points index:'
# cluster_number = 0
# for cluster in scan.clusters:
#     print '=== Cluster %d ===' % cluster_number
#     print 'Cluster points index: %s' % list(cluster)
#     cluster_number += 1
#
# print '\nCluster assigned to each point:'
# for i in xrange(len(scan.points)):
#     print '=== Point: %s ===' % scan.points[i]
#     print 'Cluster: %2d' % scan.points_data[i].cluster,
#     # If a point cluster is -1, it's an anomaly
#     if scan.points_data[i].cluster == -1:
#         print '\t <== Anomaly found!'
#     else:
#         print

cluster_number = 0
point_arr = []
for cluster in scan.clusters:
    cluster_number+=1
    lat_sum = 0.0
    lng_sum = 0.0
    for cl in list(cluster):
        lat_sum += float(arr[cl][0])
        lng_sum += float(arr[cl][1])
    lat = lat_sum/len(list(cluster))
    lng = lng_sum/len(list(cluster))
    point_arr.append([lat, lng])
    # print '{ "type": "Feature", "id": '+str(cluster_number)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(lat)+' , '+str(lng)+'] } },'

p=np.array(point_arr)

print '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
print point_arr
points = p
lines = voronoi2(points)
print '---------------'
print lines

for i in range(0, len(point_arr)):
    print "--------------------", i, "--------------------"
    print (point_arr[i])
    print lines[i]

# print lines
plt.scatter(points[:, 0], points[:, 1], color="blue")
lines1 = matplotlib.collections.LineCollection(lines, color='red')
plt.gca().add_collection(lines1)
plt.axis((35, 40, 20, 25))
plt.show()




