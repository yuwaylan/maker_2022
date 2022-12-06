from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World!"

if __name__=="__main__":
    app.run(host="0.0.0.0", port=8888)from flask import Flask,request
import json

app = Flask(__name__)

file_content = ""

@app.route("/")
def hello():
    return "Hello, World!"
    
    
@app.route("/get_status")
def get_status():
    f = open("status.txt","r")
    lines = f.readlines()
    file_content = lines
    print(file_content)
    return str(file_content[0]);

@app.route('/set_status/<status>')
def set_status(status):
    f = open("status.txt","w")
    f.write(status)
    return status

@app.route("/get_modes")
def get_modes():
    f = open("mode.txt","r")
    lines = f.readlines()
    file_content = lines
    print(file_content)
    return str(file_content[0]);
    
@app.route('/set_modes/<modes>')
def set_modes(modes):
    f = open("mode.txt","w")
    f.write(modes)
    return modes


if __name__=="__main__":
    app.run(host="0.0.0.0")

