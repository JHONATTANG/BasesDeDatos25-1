    def create_ia_tab(self):
        """Crear la pestaña de consultas con IA"""
        tab = QWidget()
        layout = QVBoxLayout()
        
        # Campo de entrada para el prompt
        self.prompt_label = QLabel("Ingrese su prompt para consultar la base de datos:")
        self.prompt_input = QTextEdit()
        self.prompt_input.setMaximumHeight(100)
        
        # Botón para ejecutar
        self.execute_ia_button = QPushButton("Consultar con IA")
        self.execute_ia_button.clicked.connect(self.execute_ia_query)
        
        # Campo de salida para la respuesta
        self.ia_result_display = QTextEdit()
        self.ia_result_display.setReadOnly(True)
        
        # Añadir widgets al layout
        layout.addWidget(self.prompt_label)
        layout.addWidget(self.prompt_input)
        layout.addWidget(self.execute_ia_button)
        layout.addWidget(QLabel("Respuesta:"))
        layout.addWidget(self.ia_result_display)
        
        tab.setLayout(layout)
        return tab
    
    def execute_ia_query(self):
        """Ejecutar consulta con IA"""
        prompt = self.prompt_input.toPlainText()
        if not prompt:
            return
            
        self.ia_result_display.setText("Procesando...")
        
        try:
            # Ejemplo con OpenAI (necesitarías configurar tu API key)
            # openai.api_key = "tu_api_key"
            
            # Obtener esquema de la base de datos para dar contexto
            schema_info = self.get_database_schema()
            
            full_prompt = f"Tengo una base de datos con la siguiente estructura:\n{schema_info}\n\nConsulta: {prompt}\n\nGenera una respuesta en texto natural basada en los datos disponibles."
            
            # Simulación de respuesta (en producción usarías la API real)
            response = "Respuesta simulada de la IA basada en el esquema de la base de datos y el prompt proporcionado."
            # response = openai.Completion.create(
            #     engine="text-davinci-003",
            #     prompt=full_prompt,
            #     max_tokens=500
            # ).choices[0].text
            
            self.ia_result_display.setText(response)
        except Exception as e:
            self.ia_result_display.setText(f"Error: {str(e)}")
    
    def get_database_schema(self):
        """Obtener información del esquema de la base de datos para la IA"""
        # Esto es un ejemplo - deberías adaptarlo a tu esquema real
        schema = """
        Base de datos de ciclismo:
        - Tabla ciclistas: id, nombre, edad, equipo, nacionalidad
        - Tabla carreras: id, nombre, fecha, ubicacion
        - Tabla victorias: id, ciclista_id, carrera_id, fecha
        """
        return schema