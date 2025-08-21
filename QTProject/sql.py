    def create_sql_tab(self):
        """Crear la pestaña de consultas SQL"""
        tab = QWidget()
        layout = QVBoxLayout()
        
        # Radio buttons para las consultas
        self.sql_radio1 = QRadioButton("Consulta SQL 1")
        self.sql_radio2 = QRadioButton("Consulta SQL 2")
        self.sql_radio3 = QRadioButton("Consulta SQL 3")
        self.sql_radio4 = QRadioButton("Consulta SQL 4")
        self.sql_radio5 = QRadioButton("Consulta SQL 5")
        
        # Conectar señales
        self.sql_radio1.toggled.connect(lambda: self.execute_sql_query(1))
        self.sql_radio2.toggled.connect(lambda: self.execute_sql_query(2))
        self.sql_radio3.toggled.connect(lambda: self.execute_sql_query(3))
        self.sql_radio4.toggled.connect(lambda: self.execute_sql_query(4))
        self.sql_radio5.toggled.connect(lambda: self.execute_sql_query(5))
        
        # Campos de salida
        self.sql_query_display = QTextEdit()
        self.sql_query_display.setReadOnly(True)
        self.sql_result_table = QTableWidget()
        
        # Añadir widgets al layout
        layout.addWidget(self.sql_radio1)
        layout.addWidget(self.sql_radio2)
        layout.addWidget(self.sql_radio3)
        layout.addWidget(self.sql_radio4)
        layout.addWidget(self.sql_radio5)
        layout.addWidget(QLabel("Consulta SQL:"))
        layout.addWidget(self.sql_query_display)
        layout.addWidget(QLabel("Resultado:"))
        layout.addWidget(self.sql_result_table)
        
        tab.setLayout(layout)
        return tab
    
    def execute_sql_query(self, query_num):
        """Ejecutar consulta SQL según el número seleccionado"""
        if not self.sender().isChecked():
            return
            
        queries = {
            1: ("SELECT * FROM ciclistas LIMIT 10", "Consulta básica de ciclistas"),
            2: ("SELECT nombre, edad FROM ciclistas WHERE edad > 25", "Ciclistas mayores de 25 años"),
            3: ("SELECT equipo, COUNT(*) as total FROM ciclistas GROUP BY equipo", "Conteo por equipo"),
            4: ("SELECT * FROM carreras WHERE fecha > '2023-01-01'", "Carreras del 2023"),
            5: ("SELECT c.nombre, COUNT(*) as victorias FROM ciclistas c JOIN victorias v ON c.id = v.ciclista_id GROUP BY c.nombre ORDER BY victorias DESC", "Ciclistas con más victorias")
        }
        
        query, description = queries.get(query_num, ("SELECT 1", "Consulta por defecto"))
        self.sql_query_display.setText(f"-- {description}\n{query}")
        
        try:
            cursor = self.sql_conn.cursor()
            cursor.execute(query)
            result = cursor.fetchall()
            
            # Mostrar resultados en la tabla
            self.display_sql_results(cursor.description, result)
        except Exception as e:
            self.sql_query_display.append(f"\nError: {str(e)}")
    
    def display_sql_results(self, headers, data):
        """Mostrar resultados SQL en la tabla"""
        self.sql_result_table.clear()
        
        if not headers or not data:
            return
            
        self.sql_result_table.setColumnCount(len(headers))
        self.sql_result_table.setRowCount(len(data))
        
        # Configurar encabezados
        self.sql_result_table.setHorizontalHeaderLabels([h[0] for h in headers])
        
        # Llenar la tabla con datos
        for row_idx, row in enumerate(data):
            for col_idx, value in enumerate(row):
                self.sql_result_table.setItem(row_idx, col_idx, QTableWidgetItem(str(value)))