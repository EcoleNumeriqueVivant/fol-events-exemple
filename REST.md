# Curl

http://blogs.plexibus.com/2009/01/15/rest-esting-with-curl/

```
curl \
  -X POST \
  -i -H "Accept: application/json" \
  -d 'email=email@example.com&password=password' \
  -c cookie \
  http://localhost:3000/api/auth/login.json > tmp/login.json

curl \
  -X DELETE \
  -i -H "Accept: application/json" \
  http://localhost:3000/auth/logout.json > tmp/logout.json
```