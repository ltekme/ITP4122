
from flask import Flask

cas = Flask(__name__)


@cas.route("/")
def index():
    
    return "<h1>Hello, Welcome to cas</h1>"


if __name__ == "__main__":
    cas.run()
