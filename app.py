
from flask import Flask, jsonify, request
import os

app = Flask(__name__)


GREETING = os.environ.get("GREETING", "Welcome to the custom app")
LOG_LEVEL = os.environ.get("LOG_LEVEL", "INFO")
PORT = int(os.environ.get("APP_PORT", 5000))

LOG_FILE = "/app/logs/app.log"

@app.route("/")
def index():
    return GREETING

@app.route("/status")
def status():
    return jsonify({"status": "ok"})

@app.route("/log", methods=["POST"])
def log_message():
    data = request.get_json()
    message = data.get("message", "")
    with open(LOG_FILE, "a") as f:
        f.write(message + "\n")
    return jsonify({"logged": message})

@app.route("/logs")
def get_logs():
    if os.path.exists(LOG_FILE):
        with open(LOG_FILE, "r") as f:
            content = f.read()
        return content
    else:
        return "Log file not found", 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)

