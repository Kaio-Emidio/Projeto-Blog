from flask import Flask
from auth.rotas import auth
from posts.rotas import posts

app = Flask(__name__)
app.secret_key = "chave_secreta"

app.register_blueprint(auth)
app.register_blueprint(posts)

if __name__ == "__main__":
    app.run(debug=True)