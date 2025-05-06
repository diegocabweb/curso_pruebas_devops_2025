# Docker Hola Mundo Python

Un simple contenedor Docker que ejecuta un script de Python que muestra "¡Hola Mundo desde un contenedor Docker!".

## Estructura del proyecto

```
.
├── Dockerfile     # Configuración para construir la imagen Docker
├── hola_mundo.py  # Script de Python que imprime el mensaje
└── README.md      # Este archivo
```

## Requisitos previos

- Docker instalado en tu sistema

## Instrucciones

### Para construir la imagen

```bash
docker build -t python-hola-mundo .
```

### Para ejecutar el contenedor

```bash
docker run python-hola-mundo
```

## Resultado esperado

Al ejecutar el contenedor, verás:
```
¡Hola Mundo desde un contenedor Docker!
```
