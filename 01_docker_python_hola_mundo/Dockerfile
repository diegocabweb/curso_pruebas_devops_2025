#Utilizamos la imagen oficial de Python como base
FROM python:3.9-slim

#Establecemos el directorio de trabajo en el contenedor
WORKDIR /app

#Copiamos nuestro script de Python al contenedor
COPY hola_mundo.py .

#Damos permisos de ejecución al script 
RUN chmod +x hola_mundo.py

#Comando que se ejecute al inicial el contedor
CMD ["python", "hola_mundo.py"]
