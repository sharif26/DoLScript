#!/bin/bash

while :
do

date
## curl URL is captured from chrome developers tool, Network tab
curl 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearchGridData&caseNumberList=P%2D100%2D16306%2D547678&page=1&rows=10&sidx=case_number&sord=asc&nd=1467037245088&_search=false' -H 'Cookie: _ga=GA1.2.246802986.1466698499; CFID=4629992; CFTOKEN=41708843; BIGipServerp_ICERT_prod_URL=2466250762.20480.0000' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,bn;q=0.6' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36' -H 'Accept: application/json, text/javascript, */*' -H 'Referer: https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed > pwd.json
## send email to self when status is not empty or not in process
## output is json response, so parsed using python
status=`cat pwd.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["ROWS"][0][4]'`
if [ "$status" != "in process" ] && [ "$status" != "" ] ; then
        news=`cat pwd.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["ROWS"][0][3], obj["ROWS"][0][4]'`
        echo $news | mailx -s "PWD update" -a "From: sahmed@chesterfield.mo.us" -r sahmed@chesterfield.mo.us 
fi
## it will check status for every 3 hours
sleep 3h
done
