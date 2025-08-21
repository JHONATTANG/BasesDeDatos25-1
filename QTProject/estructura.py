import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QTabWidget, QWidget, QVBoxLayout, 
                             QRadioButton, QTextEdit, QTableWidget, QLabel, QLineEdit, 
                             QPushButton, QComboBox, QFileDialog)
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt
import pymongo
from pymongo import MongoClient
import mysql.connector
import openai  # Para la pestaña de IA








class ComparativoApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Comparativo SQL vs MongoDB")
        self.setGeometry(100, 100, 800, 600)
        
        # Configuración de conexiones a bases de datos
        self.setup_db_connections()
        
        # Configurar la interfaz principal
        self.setup_ui()
        
    def setup_db_connections(self):
        # ""Configurar conexiones a bases de datos""
        # Configuración SQL (MySQL)
        self.sql_conn = mysql.connector.connect(
            host="localhost",
            user="tu_usuario",
            password="tu_contraseña",
            database="tu_basedatos"
        )
        
        # Configuración MongoDB
        self.mongo_client = MongoClient('localhost', 27017)
        self.mongo_db = self.mongo_client['tu_basedatos']
        
    def setup_ui(self):
        #""Configurar la interfaz de usuario principal""
        self.tabs = QTabWidget()
        
        # Crear las pestañas
        self.sql_tab = self.create_sql_tab()
        self.mongo_tab = self.create_mongo_tab()
        self.ia_tab = self.create_ia_tab()
        self.photo_tab = self.create_photo_tab()
        
        # Añadir pestañas al widget principal
        self.tabs.addTab(self.sql_tab, "SQL")
        self.tabs.addTab(self.mongo_tab, "MONGO")
        self.tabs.addTab(self.ia_tab, "IA")
        self.tabs.addTab(self.photo_tab, "FOTO")
        
        self.setCentralWidget(self.tabs)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ComparativoApp()
    window.show()
    sys.exit(app.exec_())

"""
import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QTabWidget, QWidget, QVBoxLayout, 
                             QRadioButton, QTextEdit, QTableWidget, QLabel, QLineEdit, 
                             QPushButton, QComboBox, QFileDialog)
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt
import pymongo
from pymongo import MongoClient
import mysql.connector
import openai  # Para la pestaña de IA

class ComparativoApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Comparativo SQL vs MongoDB")
        self.setGeometry(100, 100, 800, 600)
        
        # Configuración de conexiones a bases de datos
        self.setup_db_connections()
        
        # Configurar la interfaz principal
        self.setup_ui()
        
    def setup_db_connections(self):
        # ""Configurar conexiones a bases de datos""
        # Configuración SQL (MySQL)
        self.sql_conn = mysql.connector.connect(
            host="localhost",
            user="tu_usuario",
            password="tu_contraseña",
            database="tu_basedatos"
        )
        
        # Configuración MongoDB
        self.mongo_client = MongoClient('localhost', 27017)
        self.mongo_db = self.mongo_client['tu_basedatos']
        
    def setup_ui(self):
        #""Configurar la interfaz de usuario principal""
        self.tabs = QTabWidget()
        
        # Crear las pestañas
        self.sql_tab = self.create_sql_tab()
        self.mongo_tab = self.create_mongo_tab()
        self.ia_tab = self.create_ia_tab()
        self.photo_tab = self.create_photo_tab()
        
        # Añadir pestañas al widget principal
        self.tabs.addTab(self.sql_tab, "SQL")
        self.tabs.addTab(self.mongo_tab, "MONGO")
        self.tabs.addTab(self.ia_tab, "IA")
        self.tabs.addTab(self.photo_tab, "FOTO")
        
        self.setCentralWidget(self.tabs)

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = ComparativoApp()
    window.show()
    sys.exit(app.exec_())
"""