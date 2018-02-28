from urllib.request import Request
from urllib.request import urlopen
import json
import sys

day_part = 'P-100-17321-'
cookie = '_ga=GA1.2.1624052008.1513884104; NSC_TJMJDFSUXFC_443_MC=ffffffff09391c2b45525d5f4f58455e445a4a423660; '
randseq = 0

if len(sys.argv) >= 2:
	cookie += sys.argv[1] + '; _gat=1;'
if len(sys.argv) >= 3:
	day_part = sys.argv[2]
if len(sys.argv) >= 4:
	randseq = int(sys.argv[3])

for i in range(10000):
	url = 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearchGridData&page=1&rows=100&sidx=case_number&sord=asc&nd=1516203577655&_search=false&caseNumberList=P-100-17313-906932'
	for j in range(100): 
		url += '|' + day_part + str(format(randseq, '06'))
		randseq = randseq + 1

	req = Request(url)
	req.add_header('Cookie', cookie)
	req.add_header('Referer', 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch')
	resp = urlopen(req)
	content = resp.read().decode('utf8')
	#print content
	try:
		obj = json.loads(content)
		if obj['ROWS'] != "":
			#for case in obj['ROWS']:
			#	if case[4] == 'determination issued':
			#		print case
			print (content)
	except ValueError:
		print ('No valid json found, possible reason: expired cookie')
		break