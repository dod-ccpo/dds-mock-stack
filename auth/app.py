#!/usr/bin/env python

import tornado.ioloop
import tornado.web
import json
import sys

class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("This is auth")

class StatusHandler(tornado.web.RequestHandler):
    def get(self):
        self.write(json.dumps({"name" : "auth", "status" : "ok", "version" : "0.0.4"}))

def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/status", StatusHandler),
    ])

if __name__ == "__main__":
    if len(sys.argv) < 2:
        port = '8888'
    else:
        port = sys.argv[1]
    print("listening on " + port)
    app = make_app()
    app.listen(port)
    tornado.ioloop.IOLoop.current().start()
