from flask import Flask, jsonify, request

import time

app = Flask(__name__)

@app.before_request
def log_request():
    print(f"SOURCE APP RECEIVED: {request.method} {request.path}?{request.query_string.decode()}")

@app.route("/")
def home():
    return """
    <h1>GoReplay Demo Source App</h1>
    <p>Click any link below to generate traffic on the source app.</p>
    <ul>
        <li><a href="/api/data?q=hello">Normal request</a></li>
        <li><a href="/api/data?q=test123">Another normal request</a></li>
        <li><a href="/api/slow">Slow request</a></li>
        <li><a href="/api/error">Error request</a></li>
    </ul>
    """

@app.route("/api/data")
def get_data():
    return jsonify({
        "status": "ok",
        "message": "sample response",
        "query": request.args.get("q", "none")
    })

@app.route("/api/slow")
def slow():
    time.sleep(0.2)
    return jsonify({
        "status": "ok",
        "message": "slow response"
    })

@app.route("/api/error")
def error():
    return jsonify({
        "status": "error",
        "message": "intentional test error"
    }), 500

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)