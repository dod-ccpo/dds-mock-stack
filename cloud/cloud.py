#!/usr/bin/env python

from flask import Flask, jsonify
app = Flask(__name__)

@app.route("/")
def hello():
    return "This is cloud version 0.0.1"

@app.route("/status")
def version():
    return jsonify({ "version" : "0.0.1", "status" : "ok" })
