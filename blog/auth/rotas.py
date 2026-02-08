from flask import Blueprint, render_template, request, redirect, session
from werkzeug.security import generate_password_hash, check_password_hash
from bd import conectar

auth = Blueprint("auth", __name__)

@auth.route("/cadastro", methods=["GET", "POST"])
def cadastro():
    if request.method == "POST":
        nome = request.form.get("nome")
        email = request.form.get("email")
        senha = generate_password_hash(request.form.get("senha"))
        bio = request.form.get("bio")

        bd = conectar()
        cursor = bd.cursor()
        cursor.execute(
            "INSERT INTO Autores(Nome, Email, Senha_cripto, Bio) \
            Values (%s, %s, %s, %s)", (nome, email, senha, bio)
        )
        bd.commit()
        return redirect("/login")
    return render_template("cadastro.html")

@auth.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email")
        senha = request.form.get("senha")

        bd = conectar()
        cursor = bd.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Autores WHERE Email=%s", (email,))
        autor = cursor.fetchone()

        if autor and check_password_hash(autor["Senha_cripto"], senha):
            session["autor_id"] = autor["ID_Autor"]
            session["autor_nome"] = autor["Nome"]
            return redirect("/")
    return render_template("login.html")

@auth.route("/sair")
def sair():
    session.clear()
    return redirect("/")