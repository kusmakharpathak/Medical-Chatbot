from flask import Flask, render_template, request
import os

from model.model_connect import chat

app = Flask(__name__)


@app.route('/')
def hello_world():
    return render_template('index.html')


@app.route('/connect', methods=['POST', 'GET'])
def connect():
    message = request.args.to_dict()
    return chat(message=message['message'])


if __name__ == '__main__':
    app.run()
