# Docker con Nginx - Hola Mundo

Este proyecto crea un contenedor Docker con Nginx configurado para servir una página web personalizada "Hola Mundo".

## Estructura del proyecto

```
.
├── Dockerfile     # Configuración para construir la imagen Docker
├── default.conf   # Configuración personalizada de Nginx
├── index.html     # Página web "Hola Mundo" personalizada
└── README.md      # Este archivo
```

## Requisitos previos

- Docker instalado en tu sistema

## Instrucciones

### Para construir la imagen

```bash
docker build -t nginx-hola-mundo .
```

### Para ejecutar el contenedor

```bash
docker run -d -p 8080:80 --name nginx-container nginx-hola-mundo
```

Este comando ejecuta el contenedor en segundo plano (-d) y mapea el puerto 8080 de tu máquina al puerto 80 del contenedor.

### Para acceder a la página web

Abre tu navegador y visita:
```
http://localhost:8080
```

### Para detener y eliminar el contenedor

```bash
docker stop nginx-container
docker rm nginx-container
```

## Explicación técnica

- **FROM nginx:alpine**: Usamos la versión Alpine de Nginx, que es más ligera que la versión estándar.
- **RUN rm /etc/nginx/conf.d/default.conf**: Eliminamos la configuración por defecto.
- **COPY default.conf /etc/nginx/conf.d/**: Copiamos nuestra configuración personalizada.
- **COPY index.html /usr/share/nginx/html/**: Copiamos nuestro archivo HTML al directorio que Nginx utiliza para servir contenido.
- **EXPOSE 80**: Informamos que el contenedor escucha en el puerto 80.

