#!/bin/bash

while :
do

date

curl 'https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspQuickCertSearchGridData&&startSearch=1&case_number=&employer_business_name=northern%20kentucky&visa_class_id=6&state_id=all&location_range=10&location_zipcode=&job_title=&naic_code=&create_date=undefined&post_end_date=undefined&h1b_data_series=ALL&start_date_from=06/01/2016&start_date_to=&end_date_from=12/31/2016&end_date_to=mm/dd/yyyy&nd=1474663765137&page=1&rows=20&sidx=create_date&sord=desc&nd=1474663765137&_search=false' -H 'Cookie: _ga=GA1.2.246802986.1466698499; CFID=4446739; CFTOKEN=93324075; BIGipServerp_LCJR_URL_80=2516582410.20480.0000' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8,bn;q=0.6' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36' -H 'Accept: application/json, text/javascript, */*' -H 'Referer: https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspQuickCertSearch' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed > perm.json

status=`cat perm.json| python -c 'import json,sys;obj=json.load(sys.stdin);print len(obj["ROWS"])'`
if [ "$status" != 0 ] && [ "$status" != "" ] ; then
        news=`cat perm.json | python -c 'import json,sys;obj=json.load(sys.stdin);print "case:", obj["ROWS"][0][1], "status:", obj["ROWS"][0][4], "\n"; a = "https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspCert&doc_id=3&visa_class_id=6&id=" + str(obj["ROWS"][0][0]); print a;'`
        echo $news | mailx -s "PERM update" -a "From: sahmed@chesterfield.mo.us" -r sahmed@chesterfield.mo.us 
fi

sleep 3h
done
