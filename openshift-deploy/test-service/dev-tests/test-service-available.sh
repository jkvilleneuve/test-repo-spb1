RESP=$(curl -X POST -sL -w "%{http_code}\\n" "http://test-service-z-dev-project.apps.neoflex.ru/test-service/calculate" -o /dev/null)

echo $RESP

if [ $RESP -ne 200 ]; then
	echo "URL not available, stop pipeline!"
	exit $RESP
fi
	


