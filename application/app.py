
import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def home():
    return jsonify({
        "application": "aws-zero-trust-web-platform",
        "status": "running",
        "environment": os.getenv("APP_ENV", "dev")
    })

@app.get("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.get("/ready")
def ready():
    # Database readiness will be implemented in a later step.
    return jsonify({"status": "ready"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))
