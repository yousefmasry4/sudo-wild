#sudo service mongod start
#mongo -u ian -p secretPassword 123.45.67.89/cool_db
# coding: utf-8
import uuid 
import search,os
from PIL import Image
import numpy as np
import networkx as nx
import datetime
from flask import Flask   , request , send_from_directory
from flask_restful import Resource  , Api
from pymongo import MongoClient
conn = MongoClient('localhost', 27017)
db = conn["sudo"]["loger"]
import glob
app = Flask(__name__)
PROJECT_HOME = os.path.dirname(os.path.realpath(__file__))
UPLOAD_FOLDER = '{}/uploads/'.format(PROJECT_HOME)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


UPLOAD_FOLDER2 = '{}/report img/'.format(PROJECT_HOME)
app.config['UPLOAD_FOLDER2'] = UPLOAD_FOLDER2

app.debug=True
api = Api(app)
data_img=(glob.glob("uploads/*.*"))
data_img2=(glob.glob("report img/*.*"))
def create_new_folder(local_dir):
    newpath = local_dir
    if not os.path.exists(newpath):
        os.makedirs(newpath)
    return newpath
def filename_get(_id):
    for i in data_img:
        a,b=i.split(".")
        _,a=a.split("/")
        print(a)
        if str(a) == str(_id):
            print("asassadasdasdsdaasd",str(a)+"."+str(b))
            return str(str(a)+"."+str(b))
    return 0
class img(Resource):
    def post(self):

        img = request.files['image']
        try_pre=filename_get(img.filename)
        if  try_pre != 0:
            os.remove('uploads/'+str(try_pre)) 
        create_new_folder(app.config['UPLOAD_FOLDER']) 
        saved_path = os.path.join(app.config['UPLOAD_FOLDER'], img.filename)
        img.save(saved_path)
        data=search.photo(saved_path)
        os.remove(saved_path)
        return data
class report(Resource):
    def post(self):
        data = request.form
        db=conn["wild"]["reports"]
        try:
            img = request.files['img']
            print(data)
            create_new_folder(app.config['UPLOAD_FOLDER2']) 
            saved_path = os.path.join(app.config['UPLOAD_FOLDER2'], img.filename)
            img.save(saved_path)
            db.insert_one({"data":data["data"],"loc":data["loc"],"link":data["link"],'img':img.filename})
        except:
            db.insert_one({"data":data["data"],"loc":data["loc"],"link":data["link"],"img":"null"})
class savedata(Resource):
    def get(self):
        data = request.form
        db=conn["wild"]["temp"]
        datadb=list(db.find({"id":data["c"]}))
        print(datadb)

        return send_from_directory(app.config['UPLOAD_FOLDER2'],datadb[0]["img"], as_attachment=False)
    def post(self):
        db=conn["wild"]["temp"]
        img = request.files['img']
        create_new_folder(app.config['UPLOAD_FOLDER2']) 
        saved_path = os.path.join(app.config['UPLOAD_FOLDER2'], img.filename)
        img.save(saved_path)
        c=str(uuid.uuid1())
        db.insert_one({"id":c+img.filename,'img':img.filename})
        return {"msg":c+img.filename}

api.add_resource(img, '/img') #done
api.add_resource(report, '/re') #done
api.add_resource(savedata, '/save') #done
if __name__ == '__main__':
    app.run(host='192.168.1.3',port=5000, debug=True)
    