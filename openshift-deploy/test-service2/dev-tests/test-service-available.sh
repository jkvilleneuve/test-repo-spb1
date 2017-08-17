RESP=$(curl -X POST -sL -w "%{http_code}\\n" "http://test-service2-z-dev-project.apps.oc.ymelnik.ru/test-service2/getSum" -o /dev/null)

echo $RESP

if [ $RESP -ne 200 ]; then
	echo "URL not available, stop pipeline!"
	exit $RESP
fi
	


