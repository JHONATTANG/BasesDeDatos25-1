import pandas as pd

datos = {'nombre': ['Miguel', 'Mario', 'Pedro', 'Lucy'],
               'edad': [32, 45, 38, 43],
               'ciudad': ['Medellín','Bogotá','San Andrés','Pasto']}
print(datos)

#Agregar
datos['nuevo'] = [1,2,3,None]
print(datos)

df = pd.DataFrame(datos)
print(df)

#Actualizar
datos.update({'edad':[28,32,11,22]})
print(datos)

#Eliminar índice
datos.pop('ciudad')
print(datos)

#Limpiar dataFrame
datos.clear()
print(datos)