import sys
import pandas as pd
from urllib.parse import quote_plus

from PyQt6 import uic, QtWidgets
from PyQt6.QtGui import QPixmap
from sqlalchemy import create_engine


import requests
import json


import base64
from matplotlib import pyplot as plt
from matplotlib import image as mpimg

# Bases de datos

password = "28052411TT@gu*"
encoded_password = quote_plus(password)
connection_string = f"mysql+pymysql://root:{encoded_password}@127.0.0.1:3306/tour"
conn = create_engine(connection_string)

#create_engine('tipo_de_base_de_datos://usuario:contraseña@host:puerto/base_de_datos')
#conn = create_engine('mysql+pymysql://root:28052411TT@gu*@127.0.0.1:3306/tour')
#Ejecutar un query (1)
#df=pd.read_sql("SELECT * FROM camiseta", conn)
#print(df)






#### querys sql

QUERY1 = """
-- 5.Nombre y el equipo de los ciclistas que han ganado alguna etapa llevando la camiseta de color amarillo, mostrando también el número de etapa.
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
-- where (YEAR('2025-01-01') - YEAR(CIC.FechaNacimiento)) >=35
where CAM.Color = 'AMARILLA'
Order By CIC.IdEquipo ;
"""

QUERY2 = """
-- 2.Nombre y equipo de los corredores mayores de 35 años que han ganado algún tramo( etapa ).
Select 	CIC.Nombre "NOMBRE CICLISTA", CIC.FechaNacimiento "FECHA NACIMIENTO",
 EQ.Nombre "NOMBRE EQUIPO",  CLET.NumEtapa "ETAPA CLASIFICADA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
where timestampdiff(YEAR, FechaNacimiento, CURDATE()) >=35
Order By CIC.IdEquipo ;

"""

QUERY3 = """
-- 1.Nombre y el equipo de aquellos corredores menores de 30 años que han ganado alguna etapa.
Select 	CIC.Nombre "NOMBRE CICLISTA", CIC.FechaNacimiento "FECHA NACIMIENTO",
 EQ.Nombre "NOMBRE EQUIPO",  CLET.NumEtapa "ETAPA CLASIFICADA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join clasificacionetapa CLET On CIC.IdCiclista = CLET.IdCiclista
where timestampdiff(YEAR, FechaNacimiento, CURDATE()) <=30
Order By CIC.IdEquipo ;
"""

QUERY4 = """
-- 11.Nombre y equipo del ganador de la vuelta (es decir, el que ha lucido la camiseta amarilla en la última etapa).
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
where CAM.Color = 'AMARILLA'
Order By CIC.IdEquipo ;
"""

QUERY5 = """
-- 12.Nombre y director de los equipos que, en alguna etapa, sus ciclistas han llevado tres o más camisetas.
Select 	CIC.Nombre "NOMBRE CICLISTA", 
 EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
 CAM.Color "CAMISETA"
From Ciclistas CIC
Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
Order By CIC.IdEquipo ;
"""


### Ciclistas

QRY_Ciclistas = """"""


Formulario, Ventana = uic.loadUiType("form2.ui")


###
###label_17
def imagen(ciclista):
    #Leer archivo en formato binario
    with open('c1.jpg', 'rb') as file:
        archivo = file.read()
    #Codificar archivo a base 64
    contenido_codificado = base64.b64encode(archivo)
    print(contenido_codificado)

    #Cargarlo a una base de datos.
    idciclista = ciclista
    #query = 'UPDATE ciclistasimg SET foto = \'' +contenido_codificado+'\' WHERE'+f' id={idciclista}'
    query = f'UPDATE ciclistasimg SET foto = {contenido_codificado} WHERE idciclista={idciclista}'
    
    conn.execute(query)

    # Decodifica el contenido de la imagen en Base64
    contenido_decodificado = base64.b64decode(contenido_codificado)
    # Guarda el contenido decodificado en un archivo nuevo
    with open("imagen_decodificada3.jpg", "wb") as archivo:
        archivo.write(contenido_decodificado)
    #Publicar imagen
    image = mpimg.imread('imagen_decodificada2.jpg')
    plt.imshow(image)
    plt.show()

def deco(query2):
    #Leer archivo en formato binario
    contenido_decodificado = base64.b64decode(query2)
    # Guarda el contenido decodificado en un archivo nuevo
    with open("imagen_decodificada3.jpg", "wb") as archivo:
        archivo.write(contenido_decodificado)
    #Publicar imagen
    image = mpimg.imread('imagen_decodificada2.jpg')
    return image

#imagen(1)

class Aplicacion(QtWidgets.QMainWindow, Formulario):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Formulario.__init__(self)
        self.setupUi(self)
        
        self.RBSQL1.clicked.connect(self.SQL)
        self.RBSQL2.clicked.connect(self.SQL)
        self.RBSQL3.clicked.connect(self.SQL)
        self.RBSQL4.clicked.connect(self.SQL)
        self.RBSQL5.clicked.connect(self.SQL)
        
        """
        self.RBMONGO1.clicked.connect(self.MONGO)
        self.RBMONGO2.clicked.connect(self.MONGO)
        self.RBMONGO3.clicked.connect(self.MONGO)
        self.RBMONGO4.clicked.connect(self.MONGO)
        self.RBMONGO5.clicked.connect(self.MONGO)"""

        self.RBIA1.clicked.connect(self.IA)
        self.RBIA2.clicked.connect(self.IA)
        self.RBIA3.clicked.connect(self.IA)

        self.BTNFOTO1.clicked.connect(self.FOTO)
        self.BTNFOTO2.clicked.connect(self.FOTO2)

        #TESQL1


    def SQL(self):
        self.TESQL1.clear()
        self.TESQL2.clear()

        if(self.RBSQL1.isChecked()):
            self.TESQL1.insertPlainText(QUERY1)
            
            df=pd.read_sql(QUERY1, conn)
            print(df)

            styles = """
                <style>
                    .data-table {
                        border-collapse: collapse;
                        width: 100%;
                        font-family: Arial, sans-serif;
                        margin: 10px 0;
                    }
                    .data-table th {
                        background-color: #4CAF50;
                        color: white;
                        padding: 10px 8px;
                        text-align: left;
                        font-weight: bold;
                    }
                    .data-table td {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .data-table tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    .data-table tr:hover {
                        background-color: #e6e6e6;
                    }
                </style>
                """
    
            # Convertir DataFrame a HTML 
            table_html = df.to_html(
                index=False,
                classes="data-table",
                border=0,
                justify="left"
            )
            
            full_html = f"""
            <html>
            <head>
            {styles}
            </head>
            <body>
            {table_html}
            </body>
            </html>
            """
            
            self.TESQL2.appendHtml(full_html)


        elif(self.RBSQL2.isChecked()):
            self.TESQL1.insertPlainText(QUERY2)
            
            df=pd.read_sql(QUERY2, conn)
            print(df)

            styles = """
                <style>
                    .data-table {
                        border-collapse: collapse;
                        width: 100%;
                        font-family: Arial, sans-serif;
                        margin: 10px 0;
                    }
                    .data-table th {
                        background-color: #4CAF50;
                        color: white;
                        padding: 10px 8px;
                        text-align: left;
                        font-weight: bold;
                    }
                    .data-table td {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .data-table tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    .data-table tr:hover {
                        background-color: #e6e6e6;
                    }
                </style>
                """
    
            # Convertir DataFrame a HTML 
            table_html = df.to_html(
                index=False,
                classes="data-table",
                border=0,
                justify="left"
            )
            
            full_html = f"""
            <html>
            <head>
            {styles}
            </head>
            <body>
            {table_html}
            </body>
            </html>
            """
            
            self.TESQL2.appendHtml(full_html)


        elif(self.RBSQL3.isChecked()):
            self.TESQL1.insertPlainText(QUERY3)
            
            df=pd.read_sql(QUERY3, conn)
            print(df)

            styles = """
                <style>
                    .data-table {
                        border-collapse: collapse;
                        width: 100%;
                        font-family: Arial, sans-serif;
                        margin: 10px 0;
                    }
                    .data-table th {
                        background-color: #4CAF50;
                        color: white;
                        padding: 10px 8px;
                        text-align: left;
                        font-weight: bold;
                    }
                    .data-table td {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .data-table tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    .data-table tr:hover {
                        background-color: #e6e6e6;
                    }
                </style>
                """
    
            # Convertir DataFrame a HTML 
            table_html = df.to_html(
                index=False,
                classes="data-table",
                border=0,
                justify="left"
            )
            
            full_html = f"""
            <html>
            <head>
            {styles}
            </head>
            <body>
            {table_html}
            </body>
            </html>
            """
            
            self.TESQL2.appendHtml(full_html)
            

        elif(self.RBSQL4.isChecked()):
            self.TESQL1.insertPlainText(QUERY4)
            
            df=pd.read_sql(QUERY4, conn)
            print(df)

            styles = """
                <style>
                    .data-table {
                        border-collapse: collapse;
                        width: 100%;
                        font-family: Arial, sans-serif;
                        margin: 10px 0;
                    }
                    .data-table th {
                        background-color: #4CAF50;
                        color: white;
                        padding: 10px 8px;
                        text-align: left;
                        font-weight: bold;
                    }
                    .data-table td {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .data-table tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    .data-table tr:hover {
                        background-color: #e6e6e6;
                    }
                </style>
                """
    
            # Convertir DataFrame a HTML 
            table_html = df.to_html(
                index=False,
                classes="data-table",
                border=0,
                justify="left"
            )
            
            full_html = f"""
            <html>
            <head>
            {styles}
            </head>
            <body>
            {table_html}
            </body>
            </html>
            """
            
            self.TESQL2.appendHtml(full_html)


        elif(self.RBSQL5.isChecked()):
            self.TESQL1.insertPlainText(QUERY5)
            
            df=pd.read_sql(QUERY5, conn)
            print(df)

            styles = """
                <style>
                    .data-table {
                        border-collapse: collapse;
                        width: 100%;
                        font-family: Arial, sans-serif;
                        margin: 10px 0;
                    }
                    .data-table th {
                        background-color: #4CAF50;
                        color: white;
                        padding: 10px 8px;
                        text-align: left;
                        font-weight: bold;
                    }
                    .data-table td {
                        padding: 8px;
                        border: 1px solid #ddd;
                    }
                    .data-table tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }
                    .data-table tr:hover {
                        background-color: #e6e6e6;
                    }
                </style>
                """
    
            # Convertir DataFrame a HTML 
            table_html = df.to_html(
                index=False,
                classes="data-table",
                border=0,
                justify="left"
            )
            
            full_html = f"""
            <html>
            <head>
            {styles}
            </head>
            <body>
            {table_html}
            </body>
            </html>
            """
            
            self.TESQL2.appendHtml(full_html)
            

        else:
            self.TESQL1.insertPlainText("Ningún botón")

        """
        self.Campo_entrada_1.clear()
        if(self.radioButton_1.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 1")
        elif(self.radioButton_2.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 2")
        elif(self.radioButton_3.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 3")
        else:
            self.Campo_entrada_1.insertPlainText("Ningún botón")
        """
    
    def MONGO(self):
        A=1
        
    def IA(self):

        self.TEIA1.clear()
        self.TEIA2.clear()

        
        
        url = "http://localhost:11434/api/chat"
        


        QRY_IA = """
        Select 	CIC.Nombre "NOMBRE CICLISTA", 
        EQ.Nombre "NOMBRE EQUIPO",  ET.NumEtapa "ETAPA CLASIFICADA",
        CAM.Color "CAMISETA"
        From Ciclistas CIC
        Inner Join Equipo EQ On CIC.IdEquipo = EQ.IdEquipo
        Inner Join Premios PR On CIC.IdCiclista = PR.IdCiclista
        Inner Join Etapa ET On PR.NumEtapa = ET.NumEtapa
        Inner Join Camiseta CAM On PR.Codigo = CAM.Codigo
        -- where (YEAR('2025-01-01') - YEAR(CIC.FechaNacimiento)) >=35
        -- where CAM.Color = 'AMARILLA'
        Order By CIC.IdEquipo ;
        """
        
        df=pd.read_sql(QRY_IA, conn)
        print(df)

        df_txt = df.to_markdown(index = False)
        


        mensaje1 = f"""analice la tabla {df_txt} y devuelve el nombre del ciclista con camiseta de color amarilla"""
        mensaje2 = f"""analice la tabla {df_txt} y devuelve el nombre del ciclista con camiseta de color rosa"""
        mensaje3 = f"""analice la tabla {df_txt} y devuelve el nombre del ciclista con camiseta de color blanco"""




        payload = {
            "model": "llama3",
            "messages": [
                {"role":"user","content": mensaje1}
            ],
            "stream":False
        }
    
        response = requests.post(url,json=payload)

        
        if(self.RBIA1.isChecked()):
            self.TEIA1.insertPlainText(mensaje1)
            if response.ok :
                self.TEIA2.insertPlainText("analisis de IA \n"+response.json()["message"]["content"])
            
        elif(self.RBIA2.isChecked()):
            self.TEIA1.insertPlainText(mensaje2)
            if response.ok :
                self.TEIA2.insertPlainText("analisis de IA \n"+response.json()["message"]["content"])
        elif(self.RBIA3.isChecked()):
            self.TEIA1.insertPlainText(mensaje3)
            if response.ok :
                self.TEIA2.insertPlainText("analisis de IA \n"+response.json()["message"]["content"])

    def FOTO(self):
        
        idcic = int(self.TEFOTO1.toPlainText())

        pixmap = QPixmap('c4.jpg')
        self.label_2.setPixmap(pixmap)
        query = f"SELECT NOMBRE from cicilistasimg where idciclista={idcic}"
        query2 = f"SELECT foto from cicilistasimg where idciclista={idcic}"
        
        imagencic = conn.execute(query2).scalar()
        
        
        pixmap = QPixmap(deco(imagencic))
        self.label_2.setPixmap(pixmap)

        resultado = conn.execute(query).scalar()

        self.TEFOTO2.insertPlainText(resultado)

        

    def FOTO2(self):

        IMG = self.TEFOTO3.toPlainText()
        idcic = self.TEFOTO1.toPlainText()
        print(idcic)
        print(IMG)
        pixmap = QPixmap(IMG)
        self.label_2.setPixmap(pixmap)
        #if int(idcic) > 0 :
            #imagen(idcic)
        
        


    
        

"""
class Aplicacion(QtWidgets.QMainWindow, Formulario):
    def __init__(self):
        QtWidgets.QMainWindow.__init__(self)
        Formulario.__init__(self)
        self.setupUi(self)
        
        
        
        self.radioButton_1.clicked.connect(self.RB)
        self.radioButton_2.clicked.connect(self.RB)
        self.radioButton_3.clicked.connect(self.RB)

        self.radioButton_1.clicked.connect(self.HTML1)

        self.checkBox_1.clicked.connect(self.CB)
        self.checkBox_2.clicked.connect(self.CB)


        self.btnSum.clicked.connect(self.suma)
        
    def RB(self):
        self.Campo_entrada_1.clear()
        if(self.radioButton_1.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 1")
        elif(self.radioButton_2.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 2")
        elif(self.radioButton_3.isChecked()):
            self.Campo_entrada_1.insertPlainText("Pulse el botón 3")
        else:
            self.Campo_entrada_1.insertPlainText("Ningún botón")
    
    def CB(self):
        self.Campo_entrada_2.clear()
        if(self.checkBox_1.isChecked()):
            self.Campo_entrada_2.insertPlainText("Pulse el botón 1")
        elif(self.checkBox_2.isChecked()):
            self.Campo_entrada_2.insertPlainText("Pulse el botón 2")
        else:
            self.Campo_entrada_2.insertPlainText("Ningún botón")


    
    def suma(self):
        x1 = int(self.dial.value())
        x2 = int(self.hScrollBar.value())
        self.textEdit_1.setText(str(x1+x2))
        self.dial.setValue(20)
        self.hScrollBar.setValue(40)

    def HTML1(self):
        self.Campo_entrada_1.appendHtml("<font color='red' size='6'><red>Hola <br> Mundo </font>")
"""


if __name__=="__main__":
    app = QtWidgets.QApplication(sys.argv)
    Vent = Aplicacion()
    Vent.show()
    app.exec()
