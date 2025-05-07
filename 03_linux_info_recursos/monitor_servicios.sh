#!/bin/bash

# monitor_servicios.sh - Script para listar servicios ordenados por CPU y memoria
#
# Uso: ./monitor_servicios.sh [opciones]
#
# Opciones:
#   -n, --number NUM   Muestra los primeros NUM servicios (por defecto: todos)
#   -o, --output FILE  Guarda la salida en un archivo (por defecto: muestra en terminal)
#   -h, --help         Muestra esta ayuda y sale
#
# Ejemplo: ./monitor_servicios.sh -n 10 -o servicios.log

# Función para mostrar ayuda
show_help() {
    grep "^#" "$0" | grep -v "!/bin/bash" | sed 's/^# \?//'
    exit 0
}

# Procesamiento de parámetros
NUMBER_OF_SERVICES="all"
OUTPUT_FILE=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--number)
            NUMBER_OF_SERVICES="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo "Opción desconocida: $1"
            show_help
            ;;
    esac
done

# Verificar que existan las herramientas necesarias
for cmd in ps sort awk bc; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: El comando $cmd no está instalado." >&2
        echo "Por favor, instálalo con tu gestor de paquetes." >&2
        exit 1
    fi
done

# Función para formatear el tamaño de la memoria en formato legible
format_memory() {
    local memory_kb=$1
    
    # Para valores muy pequeños, mostrar directamente en KB
    if [ "$memory_kb" -lt 1024 ]; then
        echo "${memory_kb} KB"
        return
    fi
    
    # Convertir KB a MB
    local memory_mb=$(echo "scale=2; $memory_kb/1024" | bc)
    
    # Si es menor que 1024 MB, mostrar en MB
    if [ $(echo "$memory_mb < 1024" | bc) -eq 1 ]; then
        echo "${memory_mb} MB"
        return
    fi
    
    # Convertir MB a GB
    local memory_gb=$(echo "scale=2; $memory_mb/1024" | bc)
    echo "${memory_gb} GB"
}

# Crear encabezado con fecha y hora de ejecución
HEADER="Monitoreo de Servicios - $(date '+%Y-%m-%d %H:%M:%S')"
SEPARATOR=$(printf '%*s\n' "${#HEADER}" '' | tr ' ' '-')

# Obtener los datos de servicios
get_services_data() {
    # ps aux: Lista todos los procesos
    # --sort=-%cpu,-%mem: Ordena por CPU (primario) y MEM (secundario) en orden descendente
    # La salida de ps aux tiene esta estructura:
    # USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
    ps aux --sort=-%cpu,-%mem | awk 'NR>1 {print $2, $3, $6, $11}'
}

# Obtener y formatear los datos
format_output() {
    local data="$1"
    local limit="$2"
    
    # Si se especificó un límite
    if [ "$limit" != "all" ]; then
        data=$(echo "$data" | head -n "$limit")
    fi
    
    # Procesar cada línea
    echo "$data" | while read -r pid cpu mem cmd; do
        # Formatear memoria
        mem_formatted=$(format_memory "$mem")
        printf "%-6s %-6s %-10s %s\n" "$pid" "${cpu}%" "$mem_formatted" "$cmd"
    done
}

# Formato de cabecera
print_header() {
    echo -e "$HEADER\n$SEPARATOR\n"
    echo "PID   %CPU   MEMORIA    SERVICIO"
    echo "------------------------------------"
}

# Mostrar en pantalla
print_header
SERVICES_DATA=$(get_services_data)
format_output "$SERVICES_DATA" "$NUMBER_OF_SERVICES"

# Guardar en archivo si se especificó
if [ -n "$OUTPUT_FILE" ]; then
    {
        print_header
        format_output "$SERVICES_DATA" "$NUMBER_OF_SERVICES"
    } > "$OUTPUT_FILE"
    
    echo -e "\nResultados guardados en $OUTPUT_FILE"
fi

exit 0
