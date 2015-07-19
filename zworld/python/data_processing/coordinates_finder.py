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
    #cur.execute("SELECT * FROM `population_point` WHERE `location_lat`='0' AND `location_lng`='0' ")
    cur.execute("SELECT * FROM `population_point`")
    rows = cur.fetchall()
    for row in rows:
        print row["id"], row["point_address"]
        status = True
        while status:
            headers = {'user-agent': '"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0"'}
            full_address = row["point_address"].encode('utf-8')
            address = full_address
            address = address.split('ΣΧΟΛΕΙΟ')[-1]
            address = address.split('ΣΧΟΛΕΙΑ')[-1]
            address = address.split('ΓΥΜΝΑΣΙΟ')[-1]
            address = address.split('ΓΥΜΝΑΣΙΟΥ')[-1]
            address = address.split('ΕΠΑΛ')[-1]
            address = address.split('ΛΥΚΕΙΟΥ')[-1]
            address = address.split('ΛΥΚΕΙΟ')[-1]
            print "------>", address
            r = requests.get("https://maps.googleapis.com/maps/api/geocode/json?address="+address+"", headers=headers)
            data = json.loads(r.text)
            if data["status"] == 'OK':
                Lat = str(data["results"][0]["geometry"]["location"]["lat"])
                Lng = str(data["results"][0]["geometry"]["location"]["lng"])
                print data["results"][0]
                print "Lat: " + Lat
                print "Lng: " + Lng
                print "formatted_address: " + str(data["results"][0]["formatted_address"].encode('utf-8'))
                cur = con.cursor()
                cur.execute("UPDATE population_point SET location_lat = %s, location_lng = %s WHERE Id = %s",
                            (Lat, Lng, row["id"]))
                con.commit()
                sleep(1)
                status = False
            elif data["status"] == 'OVER_QUERY_LIMIT':
                print data["status"]
                sleep(20)
            elif data["status"] == 'ZERO_RESULTS':
                print data["status"]
                status = False
            else:
                print data["status"]
