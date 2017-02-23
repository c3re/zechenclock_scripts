#!/bin/bash
HOST="mqtt.lan"
TOPIC="waschkaue/eingangshalle/000/uhr/actuators/set_pixel"

# Pixel ansteuern erst pixel dann r g b in 0-255
function pixel {
	printf "%d #%02x%02x%02x" $1 $2 $3 $4|mosquitto_pub -h $HOST -t $TOPIC -s
	printf "painted %d -> #%02x%02x%02x\n" $1 $2 $3 $4
}
#gibt nen random dings von 0-59 zurueck
function random59 {
	echo -n $(( ( RANDOM % 60 ) ))
}
#gibt nen random dings von 0-255 zurueck
function random255 {
	echo -n $(( ( RANDOM % 256 ) ))
}

while true
do
	pixel $(random59) 0 0 255
	sleep 0.05
	pixel $(random59) 255 0 0
	sleep 0.05
	pixel $(random59) 0 255 0
	sleep 0.05
	pixel $(random59) 0 255 255
	sleep 0.05
	pixel $(random59) 255 255 0
	sleep 0.05
	pixel $(random59) 255 0 255
	sleep 0.05
done
