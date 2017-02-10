#!/bin/bash
## PERM status can be checked from: https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspQuickCertSearch
## as this page has advanced search option, it is possible to search by employer name & date range if you dont have case number
## the script can be run in any linux/unix server which has configured with email sending capabilities to notify when PERM is approved
## the script takes two command line argument: case number(A-12345-12345) and email address, can be run like below
## ./check_perm.sh A-12345-12345 test123@gmail.com
while :
do

date
case=$1                 # this does not require sed to replace dashes!
echo $case
email=$2
## curl URL is captured from chrome developers tool, Network tab
curl 'https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspQuickCertSearchGridData&&startSearch=1&case_number='$case'&employer_business_name=&visa_class_id=&state_id=all&location_range=10&location_zipcode=&job_title=&naic_code=&create_date=undefined&post_end_date=undefined&h1b_data_series=ALL&start_date_from=mm/dd/yyyy&start_date_to=mm/dd/yyyy&end_date_from=mm/dd/yyyy&end_date_to=mm/dd/yyyy&nd=1486742981145&page=1&rows=20&sidx=create_date&sord=desc&nd=1486742981146&_search=false' -H 'Cookie: CFID=14746768; CFTOKEN=36335838; BIGipServerLTM_p_ICERT_LCJR_Prod_URL=!p3smY0aQjx1CjyDZUlGZZCjJRr65Dqm7l7b2x8GFYGWobeT41PD/DQQtiNtAC6Ir1/bjETScNS2tJVU=; f5avr1688338227aaaaaaaaaaaaaaaa=IKBPMAPPPNJGJEBKPBFGGPPBGMDDKJOMMBAJPJGHLHACAFKCODHLNAJHJOPPDDGLJMCCMPIHFNONKAHAALBAKBMCAAPECOBACBGLCDCLHHNHNHPNHPBDOFEDDLCGOJJM; TS01c5f508=01cf7457d2a92a58bb739d71678c7413441febc61a02e6ad5a1c0a9ecdd724777861b09f6a803a6b5308078e468488b2217c066db48218581294faa4f91025078abd9a8a0ac1e87499ada1e5ee132c44ff828f6f8cc2ce1c96512241c9271dc2aa0981116d6748d8bfb18d43b9ad728d56dfee86834ac7aaa2964e9bbf70fdfc59fa39f619' -H 'Accept-Encoding: gzip, deflate, sdch, br' -H 'Accept-Language: en-US,en;q=0.8,bn;q=0.6' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Accept: application/json, text/javascript, */*' -H 'Referer: https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspQuickCertSearch' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed > perm.json
## output is json response, so parsed using python
status=`cat perm.json| python -c 'import json,sys;obj=json.load(sys.stdin);print len(obj["ROWS"])'`
## send email when status is not empty and no records found (when their site is under maintenance, empty string is found)
## search may take time, if found then it will also email the link of the actual approved PERM labor certificate
if [ "$status" != 0 ] && [ "$status" != "" ] ; then
        news=`cat perm.json | python -c 'import json,sys;obj=json.load(sys.stdin);print "case:", obj["ROWS"][0][1], "status:", obj["ROWS"][0][4], "\n"; a = "https://lcr-pjr.doleta.gov/index.cfm?event=ehLCJRExternal.dspCert&doc_id=3&visa_class_id=6&id=" + str(obj["ROWS"][0][0]); print a;'`
        echo $news | mailx -s "PERM update" -a "From: "$email -r $email
fi
## it will check status for every 3 hours
sleep 3h
done
