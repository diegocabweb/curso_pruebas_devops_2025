# Monitor de Servicios Linux

Este script monitorea y lista los servicios en ejecución en un sistema Linux, ordenados por porcentaje de CPU y luego por cantidad de memoria utilizada.

## Características

- Lista servicios con su PID, porcentaje de CPU, uso de memoria y nombre
- Ordena los resultados por uso de CPU (primario) y memoria (secundario)
- Formatea la memoria en unidades legibles (KB, MB, GB)
- Permite limitar el número de servicios mostrados
- Opción para guardar los resultados en un archivo

## Requisitos

- Sistema operativo Linux
- Bash shell
- Utilitarios estándar: `ps`, `sort`, `awk`, `bc`

## Instalación

1. Descarga el script:
   ```bash
   curl -O https://raw.githubusercontent.com/tu-usuario/monitor-servicios/main/monitor_servicios.sh
   ```

2. Haz el script ejecutable:
   ```bash
   chmod +x monitor_servicios.sh
   ```

## Uso

### Sintaxis básica

```bash
./monitor_servicios.sh [opciones]
```

### Opciones disponibles

- `-n, --number NUM` : Muestra los primeros NUM servicios (por defecto: todos)
- `-o, --output FILE` : Guarda la salida en un archivo (por defecto: muestra en terminal)
- `-h, --help` : Muestra la ayuda y sale

### Ejemplos

1. Mostrar todos los servicios ordenados por CPU y memoria:
   ```bash
   ./monitor_servicios.sh
   ```

2. Mostrar los 10 servicios que más CPU consumen:
   ```bash
   ./monitor_servicios.sh -n 10
   ```

3. Guardar el resultado en un archivo:
   ```bash
   ./monitor_servicios.sh -o servicios.log
   ```

4. Mostrar los 5 servicios que más CPU consumen y guardar en un archivo:
   ```bash
   ./monitor_servicios.sh -n 5 -o top5_servicios.log
   ```

## Salida de ejemplo

```
Monitoreo de Servicios - 2025-05-06 14:30:25
----------------------------------------

PID   %CPU   MEMORIA    SERVICIO
------------------------------------
1234  25.3%  1.25 GB    firefox
5678  15.7%  650.45 MB  chrome
9012  10.2%  450.32 MB  systemd
3456  8.5%   125.75 MB  nginx
7890  5.1%   95.20 MB   sshd
```

## Programación de monitoreo periódico

Puedes configurar el script para ejecutarse periódicamente usando cron:

```bash
# Ejecutar cada hora y guardar los resultados
crontab -e
```

Añade esta línea:
```
0 * * * * /ruta/a/monitor_servicios.sh -n 20 -o /var/log/monitor/servicios_$(date +\%Y\%m\%d_\%H\%M).log
```

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o un pull request en el repositorio.

## Licencia

Este proyecto está licenciado bajo la licencia MIT - ver el archivo LICENSE para más detalles.
