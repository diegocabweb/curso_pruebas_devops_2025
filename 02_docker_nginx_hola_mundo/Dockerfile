# Utilizamos la imagen oficial de Nginx como base
FROM nginx:alpine

# Eliminamos la configuración por defecto de Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copiamos nuestra configuración personalizada
COPY default.conf /etc/nginx/conf.d/

# Copiamos nuestro archivo HTML al directorio donde Nginx sirve el contenido
COPY index.html /usr/share/nginx/html/

# Exponemos el puerto 80
EXPOSE 80

# El comando CMD está ya configurado en la imagen base de Nginx
# CMD ["nginx", "-g", "daemon off;"]
