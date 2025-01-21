from flask import Flask
from routes import routes

app = Flask(__name__)

app.register_blueprint(routes)

dw_sync_queue = None

if __name__ == '__main__':
    app.run(debug=True)

def start_backend_oltp(sync_queue):
    global dw_sync_queue
    dw_sync_queue = sync_queue
    app.run(port=5000)
