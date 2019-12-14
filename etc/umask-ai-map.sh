if [ -d "/ai-map" ]
then
    umask 0002
	while true; do sleep 5 ; done
else
    echo "Voeg persistent volume /ai-map toe om de build af te kunnen ronden."
    exit 1
fi
