# DoLScript
scripts to check DoL status using case number for PWD or employer name for PERM, and notify via email when approved.
The notification can be extended to text/sms using google voice (via curl) or twilio API. 

The purpose of the bash script is to get email notification when the exact case numbers all available. 

The python script is inspired by http://www.trackitt.com/ portal and the purpose of this is to monitor which date of prevailing wage is "in process" or "determination issued" when the case number is not known. 

The cookie can be collected from chrome->dev tools->network tab.  

![chromedevtool](https://user-images.githubusercontent.com/5523584/35080212-29e82928-fbda-11e7-9bc2-a745e3165d52.PNG)

The python code is tested on python 2.7.X and 3.5.X  
> python pwd.py  
> python pwd3.py  

The python 2 version is updated to take command line argument: 1st one cookie(only the below four param needs to be there, it will append with the rest), 2nd one day part. Please try like below:
> python pwd.py "CFID=1717363; CFTOKEN=49224215;_gid=GA1.2.839183729.1519657235;_gat=1" "P-100-17348-"

Hope it will help all the waiting immigrants!
