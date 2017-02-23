#!/bin/bash
HOST="mqtt.lan"
TOPIC="waschkaue/eingangshalle/000/uhr/actuators/set_pixel"

# Pixel ansteuern erst pixel dann r g b in 0-255
function pixel {
	DIRTYFIXSECOND=$(echo -n $1|sed 's/08/8/'|sed 's/09/9/')
	printf "%d #%02x%02x%02x" $DIRTYFIXSECOND $2 $3 $4|mosquitto_pub -h $HOST -t $TOPIC -s
	printf "painted %d -> #%02x%02x%02x\n" $DIRTYFIXSECOND $2 $3 $4
}
#gibt nen random dings von 0-59 zurueck
function random59 {
	echo -n $(( ( RANDOM % 60 ) ))
}
#gibt nen random dings von 0 oder 255 zurueck
function random255 {
	echo -n $(( ( RANDOM % 2 ) * 255 ))
}
COLOR_R=$(random255)
COLOR_G=$(random255)
COLOR_B=$(random255)
LASTSECOND=$(date +%S)
while true
do
	if [ "$LASTSECOND" != "$(date +%S)" ]
	then
		LASTSECOND=$(date +%S)
		if [ "$(date +%S)" = "00" ]
		then
			COLOR_R=$(random255)
			COLOR_G=$(random255)
			COLOR_B=$(random255)
			echo "Die neue Farbe für diese Minute lautet: $COLOR_R $COLOR_R $COLOR_B"
		fi
		pixel $LASTSECOND $COLOR_R $COLOR_G $COLOR_B
	fi
done
