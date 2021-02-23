import os
from flask import Flask
import sys
import subprocess
import logging

app = Flask(__name__)

class ContainerTask():
    
    STATUS = "NOT_STARTED"
    PROCESS = None

    @classmethod
    def start(cls):
        cls.PROCESS = subprocess.Popen(["/bin/bash", "-c"] + [" ".join(sys.argv[1:])])
        cls.STATUS = "RUNNING"

    @classmethod
    def status(cls):
        if cls.PROCESS.poll() is not None:
            cls.STATUS = "SUCCESS" if cls.PROCESS.returncode == 0 else "FAILED"
        return cls.STATUS

@app.route("/status")
def status():
    return {"status": ContainerTask.status(), "command": sys.argv[1:] }

if __name__ == "__main__":
    ContainerTask.start()
    app.run(debug=True, host="0.0.0.0", port=8080)
