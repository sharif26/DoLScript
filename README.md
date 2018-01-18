# DoLScript
scripts to check DoL status using case number for PWD or employer name for PERM, and notify via email when approved.
The notification can be extended to text/sms using google voice (via curl) or twilio API. 

The purpose of the bash script is to get email notification when the exact case numbers all available. 

The python script is inspired by http://www.trackitt.com/ portal and the purpose of this is to monitor which date of prevailing wage is "in process" or "determination issued" when the case number is not known. 

The cookie can be collected from chrome->dev tools->network tab. 
![chromedevtool](https://user-images.githubusercontent.com/5523584/35080212-29e82928-fbda-11e7-9bc2-a745e3165d52.PNG)

The code is tested on python 2.7.X 
> python pwd.py  

Hope it will help all the waiting immigrants!
