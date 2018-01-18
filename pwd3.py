import random 
from urllib.request import Request
from urllib.request import urlopen
import json

def gencase(): 
	return random.randint(0, 999999)

day_part = 'P-100-17312-'

for i in range(100):
	url = 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearchGridData&page=1&rows=100&sidx=case_number&sord=asc&nd=1516203577655&_search=false&caseNumberList=P-100-17313-906932'
	for j in range(100): 
    		url += '|' + day_part + str(format(gencase(), '06')) 

	req = Request(url)
	req.add_header('Cookie', '') # cookie can be collected from chrome->dev tools->network tab
	req.add_header('Referer', 'https://icert.doleta.gov/index.cfm?event=ehRegister.caseStatusSearch')
	resp = urlopen(req)
	content = resp.read().decode('utf8')
	obj = json.loads(content)
	if obj['ROWS'] != "":
		print (content)
