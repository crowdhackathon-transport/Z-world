#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import numpy as np
import MySQLdb as mdb
import pandas as pd, matplotlib.pyplot as plt
from geopy.distance import great_circle
from scipy.cluster.vq import kmeans2, whiten, kmeans

from sklearn.cluster import DBSCAN
from scipy.spatial import distance
from sklearn.cluster import DBSCAN

def getCentroid(points):
    n = points.shape[0]
    sum_lon = np.sum(points[:, 1])
    sum_lat = np.sum(points[:, 0])
    return (sum_lon/n, sum_lat/n)

def getNearestPoint(set_of_points, point_of_reference):
    closest_point = None
    closest_dist = None
    for point in set_of_points:
        point = (point[1], point[0])
        dist = great_circle(point_of_reference, point).meters
        if (closest_dist is None) or (dist < closest_dist):
            closest_point = point
            closest_dist = dist
    return closest_point

con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8",
                  init_command='SET NAMES UTF8')

with con:
    cur = con.cursor(mdb.cursors.DictCursor)
    cur.execute("SET character_set_connection=utf8mb4;")
    #cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' ")
    #cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' AND `municipality`!='ΑΙΓΙΝΑΣ' AND `municipality`!='ΚΥΘΗΡΩΝ' AND `municipality`!='ΠΟΡΟΥ' AND `municipality`!='ΤΡΟΙΖΗΝΙΑΣ-ΜΕΘΑΝΩΝ' AND `municipality`!='ΥΔΡΑΣ' GROUP BY location_lat, location_lng;")
    cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' GROUP BY location_lat, location_lng;")

    rows = cur.fetchall()
    arr = []
    pos = 0
    for row in rows:
        pos += 1
        print '{ "type": "Feature", "id": '+str(pos)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(row["location_lat"])+' , '+str(row["location_lng"])+'] } },'
        # print "['" \
        #       + row["point_address"].encode('utf-8') + "', " \
        #       + str(row["location_lat"]) + ", " \
        #       + str(row["location_lng"]) + ", " \
        #       + str(row["id"]) + ", " \
        #       + str(row["ctizens_number"]) \
        #       + "],"
        arr.append([float(row["location_lat"]), float(row["location_lng"])])
    # arr = np.random.randn(500000*2).reshape((500000, 2))
    print "========================================================"
    print "========================================================"
    print arr
    x123 = np.array(arr).reshape(len(arr), 2)
    print "************* DBSCAN *************"
    db = DBSCAN(eps=.005, min_samples=1).fit(x123)
    print db.core_sample_indices_
    labels = db.labels_
    num_clusters = len(set(labels)) - (1 if -1 in labels else 0)
    clusters = pd.Series([x123[labels == i] for i in xrange(num_clusters)])
    print('Number of clusters: %d' % num_clusters)
    lon = []
    lat = []
    for i, cluster in clusters.iteritems():
        if len(cluster) < 3:
            representative_point = (cluster[0][1], cluster[0][0])
        else:
            representative_point = getNearestPoint(cluster, getCentroid(cluster))
        lon.append(representative_point[0])
        lat.append(representative_point[1])

        print '{ "type": "Feature", "id": '+str(i)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(getCentroid(cluster)[1])+' , '+str(getCentroid(cluster)[0])+'] } },'



    rs = pd.DataFrame({'lon':lon, 'lat':lat})
    print rs

    for i, xy in x123:
        point=[]
        point.append(row["location_lat"])
        point.append(row["location_lng"])
        representative_point = getNearestPoint(clusters.iteritems(), (row["location_lat"], row["location_lng"]))
        print i
        print representative_point