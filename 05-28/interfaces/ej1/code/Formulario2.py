import sys
from PyQt6 import uic, QtWidgets

Formulario, Ventana = uic.loadUiType("form2.ui")



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

if __name__=="__main__":
    app = QtWidgets.QApplication(sys.argv)
    Vent = Aplicacion()
    Vent.show()
    app.exec()