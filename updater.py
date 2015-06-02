#!/usr/bin/env python2.7
import socket, json, time, random
from time import strftime

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

counter = 0
while True:
    if counter == 0:
        air = random.uniform(-10.0, 30.0)
        water = random.uniform(4.0, 22.0)

        temps = dict(
            l = air,
            w = water);

        data = json.dumps(temps, ensure_ascii=False).encode("utf8")
        print data

        sock.sendto("infodisplay/temp:%s" % data, ('127.0.0.1', 4444))

    t = strftime("%H:%M")
    s = strftime("%S")
    if s == "00": print t
    sock.sendto("infodisplay/timer:%s" % t, ('127.0.0.1', 4444))

    counter = (counter + 1) % 60
    time.sleep(1)

