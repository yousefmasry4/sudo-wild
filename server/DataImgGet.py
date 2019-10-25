import requests
import webbrowser
from bs4 import BeautifulSoup
user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.47 Safari/537.36'

filePath = 'test.jpeg'
searchUrl = 'http://www.google.hr/searchbyimage/upload?hl=en'
multipart = {'encoded_image': (filePath, open(filePath, 'rb')), 'image_content':""}
response = requests.post(searchUrl, files=multipart, allow_redirects=False,headers={'User-Agent': user_agent,'hl': 'en-EG'})
url = response.headers['Location']
 
print(response.headers)