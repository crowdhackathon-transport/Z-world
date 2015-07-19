#!/usr/bin/env python
# -*- coding: utf-8 -*-

import MySQLdb as mdb
import requests
import json
from time import sleep


con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8",
                  init_command='SET NAMES UTF8')

with con:
    cur = con.cursor(mdb.cursors.DictCursor)
    cur.execute("SET character_set_connection=utf8mb4;")
    cur.execute("SELECT * FROM `population_point` WHERE `location_lat`!='0' AND `location_lng`!='0' ")
    # cur.execute("SELECT * FROM `population_point`")
    rows = cur.fetchall()
    print "-------------------------------------------------------"
    locations = []
    for row in rows:
        print "['" \
              + row["point_address"].encode('utf-8') + "', " \
              + str(row["location_lat"]) + ", " \
              + str(row["location_lng"]) + ", " \
              + str(row["id"]) + ", " \
              + str(row["ctizens_number"]) \
              + "],"