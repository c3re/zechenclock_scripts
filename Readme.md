Zechenclock colorfoo ;-)

Heyho this repo exists to give you a fast introductions to do some pixelfoo with the amazing c3zechenclock!

Here are the loose parts that may be useful:

MQTT-Broker: mqtt.lan
Topic: waschkaue/eingangshalle/000/uhr/actuators/set_pixel
Format: "<pixelnumber 0-255> #RRGGBB"

Pixel 0 is a 6 o' clock. you have to count counter-clockwise for all other pixels. Pixel 255 is a special one. it is an alias for all pixels. For example "255 #000000" will turn the clock off completely.
