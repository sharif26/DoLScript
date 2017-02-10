#!/bin/bash
## Prevailing Wage status can be checked from: https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch
## the script can be run in any linux/unix server which has configured with email sending capabilities to notify when PWD is approved
## the script takes two command line argument: case number(P-100-12345-123456) and email address, can be run like below
## ./check_pwd.sh P-100-12345-123456 test123@gmail.com

while :
do
date
case=`echo $1 | sed 's/-/%2D/g'`        # dash(-) in the case numbers need to be converted to %2D like the way space is converted to %20
echo $case
email=$2

## curl URL is captured from chrome developers tool, Network tab
curl 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearchGridData&caseNumberList='$case'&page=1&rows=10&sidx=case_number&sord=asc&nd=1467037245088&_search=false' -H 'Cookie: _ga=GA1.2.246802986.1466698499; CFID=4629992; CFTOKEN=41708843; BIGipServerp_ICERT_prod_URL=2466250762.20480.0000' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,bn;q=0.6' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36' -H 'Accept: application/json, text/javascript, */*' -H 'Referer: https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed > pwd.json
## output is json response, so parsed using python
status=`cat pwd.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["ROWS"][0][4]'`
## send email when status is not empty and not in process (when their site is under maintenance, empty string is found)
if [ "$status" != "in process" ] && [ "$status" != "" ] ; then
        news=`cat pwd.json | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["ROWS"][0][3], obj["ROWS"][0][4]'`
        echo $news | mailx -s "PWD update" -a "From: "$email -r $email
fi
## it will check status for every 3 hours
sleep 3h
done
