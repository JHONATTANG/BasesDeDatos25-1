import pymysql

# Conexión al nodo maestro
master_connection = pymysql.connect(
    host='localhost',
    user='root',
    password='micontrasena',
    port=3309,
)

# Conexión a los nodos esclavos
slave1_connection = pymysql.connect(
    host='localhost',
    user='root',
    password='contraslave',
    port=3310
)

slave2_connection = pymysql.connect(
    host='localhost',
    user='root',
    password='contraslave',
    port=3311
)

cursor = master_connection.cursor()
cursor.execute("SHOW DATABASES")

for db in cursor:
    print(db)

master_connection.close()
slave1_connection.close()
slave2_connection.close()

