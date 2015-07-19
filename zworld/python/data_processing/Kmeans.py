#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import numpy as np
import MySQLdb as mdb
from scipy.cluster.vq import kmeans2, whiten, kmeans


con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8",
                  init_command='SET NAMES UTF8')

with con:
    cur = con.cursor(mdb.cursors.DictCursor)
    cur.execute("SET character_set_connection=utf8mb4;")
    #cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' ")
    cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' AND `municipality`!='ΑΙΓΙΝΑΣ' AND `municipality`!='ΚΥΘΗΡΩΝ' AND `municipality`!='ΠΟΡΟΥ' AND `municipality`!='ΤΡΟΙΖΗΝΙΑΣ-ΜΕΘΑΝΩΝ' AND `municipality`!='ΥΔΡΑΣ' GROUP BY location_lat, location_lng;")

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
    print "************* kmeans *************"
    x, y = kmeans2(np.array(arr), 30, iter=900000000)  #<--- I randomly picked 7 clusters

    print "---->x"
    print x
    print "========================================================"
    print "========================================================"
    pos = 1
    for value in x:
        print '{ "type": "Feature", "id": '+str(pos)+',"properties": { }, "geometry": { "type": "Point", "coordinates": ['+ str(value[0])+' , '+str(value[1])+'] } },'
        pos += 1
    print "---->y"

    # print len(y)
    # for value in y:
    #     None
        #print value
        #plt.scatter(arr[:,0], arr[:,1], c=y, alpha=0.33333);

