from flask import Blueprint, render_template, request, redirect, session
from bd import conectar
from slugify import slugify

posts = Blueprint("posts", __name__)

@posts.route("/")
def inicio():
    bd = conectar()
    cursor = bd.cursor(dictionary=True)

    cursor.execute("""
        SELECT Posts.*, Categorias.Nome AS Categoria, Autores.Nome AS Autor
        FROM Posts
        JOIN Categorias ON Posts.ID_Categoria = Categorias.ID_Categoria
        JOIN Autores ON Posts.ID_Autor = Autores.ID_Autor
        WHERE Status = 'Publicado'
        ORDER BY Data_Publicacao DESC
    """)
    posts_lista = cursor.fetchall()

    cursor.execute("SELECT * FROM Categorias")
    categorias = cursor.fetchall()

    return render_template("inicio.html", posts=posts_lista, categorias=categorias)

@posts.route("/post/<slug>")
def ver_post(slug):
    bd = conectar()
    cursor = bd.cursor(dictionary=True)

    cursor.execute("""
        SELECT Posts.*, Categorias.Nome AS Categoria, Autores.Nome AS Autor, Autores.Bio
        FROM Posts
        JOIN Categorias ON Posts.ID_Categoria = Categorias.ID_Categoria
        JOIN Autores ON Posts.ID_Autor = Autores.ID_Autor
        WHERE Slug = %s
    """, (slug,))
    post = cursor.fetchone()

    return render_template("post.html", post=post)

@posts.route("/painel")
def painel():
    if "autor_id" not in session:
        return redirect("/login")

    bd = conectar()
    cursor = bd.cursor(dictionary=True)
    cursor.execute("""
        SELECT Posts.*, Categorias.Nome AS Categoria
        FROM Posts
        JOIN Categorias ON Posts.ID_Categoria = Categorias.ID_Categoria
        WHERE ID_Autor = %s
        ORDER BY Data_Publicacao DESC
    """, (session["autor_id"],))
    posts_lista = cursor.fetchall()
    return render_template("painel.html", posts=posts_lista)

@posts.route("/editar/<int:id>", methods=["GET", "POST"])
def editar_post(id):
    bd = conectar()
    cursor = bd.cursor(dictionary=True)

    if request.method == "POST":
        titulo = request.form["titulo"]
        conteudo = request.form["conteudo"]
        categoria = request.form["categoria"]
        status = request.form["status"]

        cursor.execute("""
            UPDATE Posts 
            SET Titulo=%s, Conteudo=%s, ID_Categoria=%s, Status=%s
            WHERE ID_Post=%s
        """, (titulo, conteudo, categoria, status, id))
        bd.commit()
        return redirect("/painel")

    cursor.execute("SELECT * FROM Posts WHERE ID_Post = %s", (id,))
    post = cursor.fetchone()

    cursor.execute("SELECT * FROM Categorias")
    categorias = cursor.fetchall()

    return render_template("editar_post.html", post=post, categorias=categorias)

@posts.route("/excluir/<int:id>", methods=["DELETE"])
def excluir(id):
    bd = conectar()
    cursor = bd.cursor()
    cursor.execute("DELETE FROM Posts WHERE ID_Post = %s", (id,))
    bd.commit()
    return {"ok": True}

@posts.route("/criar", methods=["GET", "POST"])
def criar():
    if "autor_id" not in session:
        return redirect("/login")

    bd = conectar()
    cursor = bd.cursor(dictionary=True)

    if request.method == "POST":
        titulo = request.form["titulo"]
        conteudo = request.form["conteudo"]
        categoria = request.form["categoria"]
        slug = slugify(titulo)

        cursor.execute("""
            INSERT INTO Posts (Titulo, Slug, Conteudo, ID_Categoria, ID_Autor, Status)
            VALUES (%s,%s,%s,%s,%s,'Publicado')
        """, (titulo, slug, conteudo, categoria, session["autor_id"]))
        bd.commit()
        return redirect("/")

    cursor.execute("SELECT * FROM Categorias")
    categorias = cursor.fetchall()
    return render_template("criar_post.html", categorias=categorias)