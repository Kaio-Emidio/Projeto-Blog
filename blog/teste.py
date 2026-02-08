import mysql.connector
print("Tentando...")

con = mysql.connector.connect(
    host="localhost",
    user="root",
    password="labinfo",
    port=3306
)

print("CONECTADO")