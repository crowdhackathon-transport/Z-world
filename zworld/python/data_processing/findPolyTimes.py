#!/usr/bin/env python
# -*- coding: utf-8 -*-
from time import sleep
import MySQLdb as mdb
import requests
import json

# SELECT tq1.id AS from_poly,  tq2.id AS to_poly
# FROM polygon AS tq1
# JOIN polygon AS tq2
# ON tq1.id != tq2.id
# LIMIT 500


# SELECT poly_table_1.lat AS start_lat, poly_table_1.lng AS start_lng, poly_table_2.lat AS end_lat, poly_table_2.lng AS end_lng FROM `polygon_distance` AS poly_dist_table
# JOIN polygon AS poly_table_1 ON poly_dist_table.start_point = poly_table_1.id
# JOIN polygon AS poly_table_2 ON poly_dist_table.end_point = poly_table_2.id
# WHERE poly_dist_table.transit_time='0' AND poly_dist_table.driving_time='0'


con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8", init_command='SET NAMES UTF8')
# con = mdb.connect('83.212.103.209', 'elections', 'elections', 'elections_db', use_unicode=True, charset="utf8", init_command='SET NAMES UTF8')

cur = con.cursor(mdb.cursors.DictCursor)
cur.execute("SET character_set_connection=utf8mb4;")
cur.execute("SELECT poly_dist_table.transit_time AS transit_time, poly_dist_table.id AS id, poly_table_1.lat AS start_lat, poly_table_1.lng AS start_lng, poly_table_2.lat AS end_lat, poly_table_2.lng AS end_lng FROM `polygon_distance` AS poly_dist_table JOIN polygon AS poly_table_1 ON poly_dist_table.start_point = poly_table_1.id JOIN polygon AS poly_table_2 ON poly_dist_table.end_point = poly_table_2.id WHERE (poly_dist_table.transit_time='0' OR poly_dist_table.driving_time='0' OR poly_dist_table.driving_distance='0' OR poly_dist_table.driving_cost='0') AND poly_dist_table.id>0 ORDER BY poly_dist_table.id")

rows = cur.fetchall()
for row in rows:
    if row["transit_time"]!=0:
        transit_time=row["transit_time"]
    else:
        transit_time = -1
    driving_time = -1
    driving_distance = -1
    driving_cost = -1

    origin = str(row["start_lat"]) + "," + str(row["start_lng"])
    destination = str(row["end_lat"]) + "," + str(row["end_lng"])
    departure_time = "1436950800" # 15/7/2015 12:00
    headers = {'user-agent': '"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Firefox/38.0"'}
    ###################### transit ######################
    if transit_time==-1:
        r = requests.get("https://maps.googleapis.com/maps/api/directions/json?origin="+origin+"&destination="+destination+"&departure_time="+departure_time+"&mode=transit", headers=headers)
        data = json.loads(r.text)
        if data["status"] == 'OK':
            transit_time = data["routes"][0]["legs"][0]["duration"]["value"]
        elif data["status"] == "ZERO_RESULTS":
            transit_time = -1
        else:
            transit_time = -2
            print data["status"]

    ###################### driving ######################
    r = requests.get("https://maps.googleapis.com/maps/api/directions/json?units=metric&avoid=tolls&origin="+origin+"&destination="+destination+"&departure_time="+departure_time+"&mode=driving", headers=headers)
    data = json.loads(r.text)
    if data["status"] == 'OK':
        driving_time = data["routes"][0]["legs"][0]["duration"]["value"]
        driving_distance = data["routes"][0]["legs"][0]["distance"]["value"]
        driving_cost=driving_distance * 0.0012
    elif data["status"] == "ZERO_RESULTS":
        driving_time = -1
    else:
        driving_time = -2
        print data["status"]

    if driving_time != -2 and transit_time != -2:
        cur = con.cursor()
        cur.execute("UPDATE polygon_distance SET transit_time = %s, driving_time = %s, driving_distance = %s, driving_cost = %s WHERE id = %s", (transit_time, driving_time, driving_distance, driving_cost, row["id"]))
        con.commit()

    print "id:" + str(row["id"]) + " transit_time:" + str(transit_time) + " driving_time:" + str(driving_time) + " driving_distance:" + str(driving_distance) + " driving_cost:" + str(driving_cost)



