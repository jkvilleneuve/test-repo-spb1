RESP=$(curl -H "Content-Type: application/json" -X POST \
	-d '{"name":"Ben","data":{"number":[1,3,51,3]}}' -sL \
	"http://test-service-z-dev-project.apps.oc.ymelnik.ru/test-service/calculate")

echo $RESP

if echo "$RESP" | grep -q 'Hello Ben'; then
	echo "Match 1 OK";
else
	echo "no Match 1";
	exit -1;
fi

if echo "$RESP" | grep -q '"sum":"58.0"'; then
	echo "Match 2 OK";
else
	echo "no Match 2";
	exit -2;
fi

if echo "$RESP" | grep -q '"difference":"50.0"'; then
	echo "Match 3 OK";
else
	echo "no Match 3"
	exit -3;
fi



	


