from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/ping')
def ping():
    return jsonify({
        'success': True,
        'message': 'You are pinging the API'
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0')