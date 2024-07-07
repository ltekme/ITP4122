
from flask import Flask

Library = Flask(__name__)


@Library.route("/")
def index():
    
    return f"<h1>Hello, Welcome to Library</h1>"


if __name__ == "__main__":
    Library.run()
