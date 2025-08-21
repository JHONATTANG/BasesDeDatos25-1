    def create_mongo_tab(self):
        """Crear la pestaña de consultas MongoDB"""
        tab = QWidget()
        layout = QVBoxLayout()
        
        # Radio buttons para las consultas
        self.mongo_radio1 = QRadioButton("Consulta MongoDB 1")
        self.mongo_radio2 = QRadioButton("Consulta MongoDB 2")
        self.mongo_radio3 = QRadioButton("Consulta MongoDB 3")
        self.mongo_radio4 = QRadioButton("Consulta MongoDB 4")
        self.mongo_radio5 = QRadioButton("Consulta MongoDB 5")
        
        # Conectar señales
        self.mongo_radio1.toggled.connect(lambda: self.execute_mongo_query(1))
        self.mongo_radio2.toggled.connect(lambda: self.execute_mongo_query(2))
        self.mongo_radio3.toggled.connect(lambda: self.execute_mongo_query(3))
        self.mongo_radio4.toggled.connect(lambda: self.execute_mongo_query(4))
        self.mongo_radio5.toggled.connect(lambda: self.execute_mongo_query(5))
        
        # Campos de salida
        self.mongo_query_display = QTextEdit()
        self.mongo_query_display.setReadOnly(True)
        self.mongo_result_table = QTableWidget()
        
        # Añadir widgets al layout
        layout.addWidget(self.mongo_radio1)
        layout.addWidget(self.mongo_radio2)
        layout.addWidget(self.mongo_radio3)
        layout.addWidget(self.mongo_radio4)
        layout.addWidget(self.mongo_radio5)
        layout.addWidget(QLabel("Consulta MongoDB:"))
        layout.addWidget(self.mongo_query_display)
        layout.addWidget(QLabel("Resultado:"))
        layout.addWidget(self.mongo_result_table)
        
        tab.setLayout(layout)
        return tab
    
    def execute_mongo_query(self, query_num):
        """Ejecutar consulta MongoDB según el número seleccionado"""
        if not self.sender().isChecked():
            return
            
        queries = {
            1: ("db.ciclistas.find().limit(10)", "Consulta básica de ciclistas"),
            2: ("db.ciclistas.find({edad: {$gt: 25}}, {nombre: 1, edad: 1})", "Ciclistas mayores de 25 años"),
            3: ("db.ciclistas.aggregate([{$group: {_id: '$equipo', total: {$sum: 1}}}])", "Conteo por equipo"),
            4: ("db.carreras.find({fecha: {$gt: ISODate('2023-01-01')}})", "Carreras del 2023"),
            5: ("db.victorias.aggregate([{$group: {_id: '$ciclista_id', victorias: {$sum: 1}}}, {$sort: {victorias: -1}}, {$lookup: {from: 'ciclistas', localField: '_id', foreignField: '_id', as: 'ciclista'}}])", "Ciclistas con más victorias")
        }
        
        query, description = queries.get(query_num, ("db.collection.find()", "Consulta por defecto"))
        self.mongo_query_display.setText(f"// {description}\n{query}")
        
        try:
            # Ejecutar consulta (esto es un ejemplo, necesitarías adaptarlo)
            collection_name = query.split('.')[1].split('(')[0]
            collection = self.mongo_db[collection_name]
            
            # Esto es simplificado - necesitarías parsear la consulta real
            if "find(" in query:
                result = list(collection.find().limit(10))
            elif "aggregate" in query:
                pipeline = []  # Necesitarías parsear el pipeline real
                result = list(collection.aggregate(pipeline))
            else:
                result = []
            
            # Mostrar resultados
            self.display_mongo_results(result)
        except Exception as e:
            self.mongo_query_display.append(f"\nError: {str(e)}")
    
    def display_mongo_results(self, data):
        """Mostrar resultados MongoDB en la tabla"""
        self.mongo_result_table.clear()
        
        if not data:
            return
            
        # Obtener todos los campos únicos para los encabezados
        headers = set()
        for doc in data:
            headers.update(doc.keys())
        headers = list(headers)
        
        self.mongo_result_table.setColumnCount(len(headers))
        self.mongo_result_table.setRowCount(len(data))
        self.mongo_result_table.setHorizontalHeaderLabels(headers)
        
        # Llenar la tabla con datos
        for row_idx, doc in enumerate(data):
            for col_idx, header in enumerate(headers):
                value = doc.get(header, "")
                if isinstance(value, dict):
                    value = str(value)  # Simplificar objetos anidados
                self.mongo_result_table.setItem(row_idx, col_idx, QTableWidgetItem(str(value)))