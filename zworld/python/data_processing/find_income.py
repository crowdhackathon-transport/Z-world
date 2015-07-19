#!/usr/bin/env python
# -*- coding: utf-8 -*-
import MySQLdb as mdb
import requests
import json
from time import sleep

con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8", init_command='SET NAMES UTF8')
cur = con.cursor(mdb.cursors.DictCursor)
cur.execute("SET character_set_connection=utf8mb4;")
cur.execute("SELECT id, lat, lng FROM `polygon` WHERE poly_name='' ORDER BY `polygon`.`id` ASC ")

rows = cur.fetchall()
for row in rows:
    headers = {'user-agent': '"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0"'}
    r = requests.get("http://maps.googleapis.com/maps/api/geocode/json?latlng="+str(row["lat"])+","+str(row["lng"])+"&sensor=false", headers=headers)
    print str(row["id"]) + "http://maps.googleapis.com/maps/api/geocode/json?latlng="+str(row["lat"])+","+str(row["lng"])+"&sensor=false"
    data = json.loads(r.text)
    address_components = []
    postal_code = "-1"
    if data["status"] == 'OK':
        address_components = data["results"][0]["address_components"]
        for component in address_components:
            if component["types"][0] == "locality":
                postal_code = component["short_name"]


    elif data["status"] == "ZERO_RESULTS":
        print data["status"]
    else:
        print data["status"]

    if postal_code != "-1":

        cur2 = con.cursor()
        cur2.execute("UPDATE polygon SET poly_name = %s WHERE id = %s",
                     (postal_code, row["id"]))
        con.commit()
    print "========================="
