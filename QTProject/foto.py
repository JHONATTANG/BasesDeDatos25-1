    def create_photo_tab(self):
        """Crear la pestaña para gestionar fotos de ciclistas"""
        tab = QWidget()
        layout = QVBoxLayout()
        
        # Botón para abrir la ventana de gestión de fotos
        self.open_photo_manager_button = QPushButton("Gestionar Fotos de Ciclistas")
        self.open_photo_manager_button.clicked.connect(self.open_photo_manager)
        
        # Añadir widgets al layout
        layout.addWidget(self.open_photo_manager_button)
        layout.addStretch()
        
        tab.setLayout(layout)
        return tab
    
    def open_photo_manager(self):
        """Abrir ventana para gestionar fotos de ciclistas"""
        self.photo_window = QWidget()
        self.photo_window.setWindowTitle("Gestión de Fotos de Ciclistas")
        self.photo_window.setGeometry(200, 200, 500, 400)
        
        layout = QVBoxLayout()
        
        # ComboBox con nombres de ciclistas
        self.cyclist_combo = QComboBox()
        self.load_cyclists()
        
        # Etiqueta para mostrar la foto
        self.photo_label = QLabel()
        self.photo_label.setAlignment(Qt.AlignCenter)
        self.photo_label.setMinimumSize(300, 300)
        self.photo_label.setStyleSheet("border: 1px solid black;")
        
        # Botón para actualizar foto
        self.update_photo_button = QPushButton("Actualizar Foto")
        self.update_photo_button.clicked.connect(self.update_cyclist_photo)
        
        # Conectar señal del ComboBox
        self.cyclist_combo.currentIndexChanged.connect(self.show_cyclist_photo)
        
        # Añadir widgets al layout
        layout.addWidget(QLabel("Seleccione un ciclista:"))
        layout.addWidget(self.cyclist_combo)
        layout.addWidget(self.photo_label)
        layout.addWidget(self.update_photo_button)
        
        self.photo_window.setLayout(layout)
        self.photo_window.show()
        
        # Mostrar la foto del primer ciclista
        self.show_cyclist_photo()
    
    def load_cyclists(self):
        """Cargar nombres de ciclistas en el ComboBox"""
        # Esto es un ejemplo - deberías cargar los datos reales de tu base de datos
        cyclists = ["Ciclista 1", "Ciclista 2", "Ciclista 3", "Ciclista 4", "Ciclista 5"]
        self.cyclist_combo.clear()
        self.cyclist_combo.addItems(cyclists)
    
    def show_cyclist_photo(self):
        """Mostrar la foto del ciclista seleccionado"""
        selected_cyclist = self.cyclist_combo.currentText()
        
        # En una aplicación real, cargarías la foto desde la base de datos
        # Esto es solo un ejemplo con una imagen por defecto
        pixmap = QPixmap("default_photo.jpg")  # Deberías tener una imagen por defecto
        
        # Escalar la imagen para que quepa en el QLabel
        self.photo_label.setPixmap(pixmap.scaled(
            self.photo_label.width(), 
            self.photo_label.height(), 
            Qt.KeepAspectRatio
        ))
    
    def update_cyclist_photo(self):
        """Actualizar la foto del ciclista seleccionado"""
        file_dialog = QFileDialog()
        file_path, _ = file_dialog.getOpenFileName(
            self.photo_window, 
            "Seleccionar Foto", 
            "", 
            "Imágenes (*.png *.jpg *.jpeg)"
        )
        
        if file_path:
            # Aquí deberías guardar la foto en tu base de datos
            # y luego actualizar la visualización
            pixmap = QPixmap(file_path)
            self.photo_label.setPixmap(pixmap.scaled(
                self.photo_label.width(), 
                self.photo_label.height(), 
                Qt.KeepAspectRatio
            ))
            
            # Guardar en base de datos (implementación dependiente de tu sistema)
            selected_cyclist = self.cyclist_combo.currentText()
            # self.save_photo_to_db(selected_cyclist, file_path)