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




## Conexion MYSQL

password = "28052411TT@gu*"
encoded_password = quote_plus(password)
connection_string = f"mysql+pymysql://root:{encoded_password}@localhost:3306/tour"
engine = create_engine(connection_string)

## Ejecutar un query (1)
df=pd.read_sql("SELECT * FROM camiseta", engine)
print(df)

"""

#create_engine('tipo_de_base_de_datos://usuario:contraseña@host:puerto/base_de_datos')
#conn = create_engine('mysql+pymysql://root:28052411TT@gu*@127.0.0.1:3306/tour')
#Ejecutar un query (1)
df=pd.read_sql("SELECT * FROM camiseta", engine)
print(df)
"""