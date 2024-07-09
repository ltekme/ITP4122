import os
from flask import Flask

app = Flask(__name__)


@app.route("/")
def index():
    internal_ip = os.environ.get("INTERNAL_POD_IP")
    return f"<h1>Hello, Welcome to Myportal. Pod IP: {internal_ip}</h1>"


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=False)