#!/usr/bin/env python
# -*- coding: utf-8 -*-

import MySQLdb as mdb
import MySQLdb as mdb2
import requests
import json
from time import sleep

con = mdb.connect('localhost', 'root', '', 'elections_db', use_unicode=True, charset="utf8", init_command='SET NAMES UTF8')
cur = con.cursor(mdb.cursors.DictCursor)
cur.execute("SET character_set_connection=utf8mb4;")
cur.execute("SELECT id, lat, lng, ASTEXT(poly) as poly, poly_name FROM `polygon` ORDER BY `polygon`.`id` ASC ")

rows = cur.fetchall()
for row in rows:

    con2 = mdb2.connect('localhost', 'root', '', 'zworld', use_unicode=True, charset="utf8", init_command='SET NAMES UTF8')
    cur2 = con2.cursor(mdb2.cursors.DictCursor)
    cur2.execute("SET character_set_connection=utf8mb4;")
    print "INSERT INTO `region`(`region_id`, `name`, `bounds`, `center`) VALUES ("+str(row["id"]) + ",'" + str(row["poly_name"]) + "',GeomFromText('" + str(row["poly"])+"'), GeomFromText('POINT("+str(row["lat"])+ " "+str(row["lng"])+ ")'))"

    cur2.execute("INSERT INTO `region`(`region_id`, `name`, `bounds`, `center`) VALUES ("+str(row["id"]) + ",'" + str(row["poly_name"]) + "',GeomFromText('" + str(row["poly"])+"'), GeomFromText('POINT("+str(row["lat"])+ " "+str(row["lng"])+ ")'))")
    con2.commit()



