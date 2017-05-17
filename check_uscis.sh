#!/bin/bash

while :
do

date

curl 'https://egov.uscis.gov/casestatus/mycasestatus.do' -H 'Cookie: JSESSIONID=3EDD73E92AE8F94796D3F7585367C833; _ga=GA1.2.1051883861.1485192427; JSESSIONID=abcl5_6Jr0u6a9O28XkQv; __utma=34570677.1051883861.1485192427.1488390724.1488390724.1; __utmb=34570677.2.10.1488390724; __utmc=34570677; __utmz=34570677.1488390724.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)' -H 'Origin: https://egov.uscis.gov' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8,bn;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://egov.uscis.gov/casestatus/mycasestatus.do' -H 'Connection: keep-alive' --data 'changeLocale=&completedActionsCurrentPage=0&upcomingActionsCurrentPage=0&appReceiptNum=WAC1790216056&caseStatusSearchBtn=CHECK+STATUS' --compressed > myuscis.txt

month=`grep 2017 myuscis.txt|awk '{print $2}'|head -1`
echo $month

if [ "$month" != "April" ] && [ "$month" != "" ] ; then
        news=`grep 2017 myuscis.txt|head -1`
        echo $news
        echo $news | mailx -s "USCIS update" -a "From: sahmed@chesterfield.mo.us" -r sahmed@chesterfield.mo.us 
        pid=`ps -ef | grep uscis | head -1 | awk '{print $2}'`
        kill -9 $pid
fi

sleep 3h
done
