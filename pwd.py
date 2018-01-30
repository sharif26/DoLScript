import random 
import urllib2
import json
import sys

def gencase(): 
	return random.randint(0, 999999)

day_part = 'P-100-17321-'
cookie = '_ga=GA1.2.1624052008.1513884104; NSC_TJMJDFSUXFC_443_MC=ffffffff09391c2b45525d5f4f58455e445a4a423660; _gid=GA1.2.1346628237.1517239944; _gat=1; '

if len(sys.argv) >= 2:
	cookie += sys.argv[1]
if len(sys.argv) == 3:
	day_part = sys.argv[2]

for i in xrange(1000):
	url = 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearchGridData&page=1&rows=100&sidx=case_number&sord=asc&nd=1516203577655&_search=false&caseNumberList=P-100-17313-906932'
	for j in xrange(100): 
    		url += '|' + day_part + str(format(gencase(), '06')) 

	req = urllib2.Request(url)
	req.add_header('Cookie', cookie)
	req.add_header('Referer', 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch')
	resp = urllib2.urlopen(req)
	content = resp.read()
	#print content
	try:
		obj = json.loads(content)
		if obj['ROWS'] != "":
			for case in obj['ROWS']:
				if case[4] == 'determination issued':
					print case
			#print content 
	except ValueError:
		print 'No valid json found, possible reason: expired cookie'
		break
