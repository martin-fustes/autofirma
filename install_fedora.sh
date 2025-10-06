#!/bin/bash

URL_AF="https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/AutoFirma_Linux_Fedora.zip"
URL_J11="https://cdn.azul.com/zulu/bin/zulu11.82.19-ca-jdk11.0.28-linux.x86_64.rpm"

AF_FILE="AutoFirma_Linux_Fedora.zip"
AF_RPM=""
J11_RPM="zulu11.82.19-ca-jdk11.0.28-linux.x86_64.rpm"

DESKTOP_FILE="$HOME/.local/share/applications/autofirma.desktop"
NEW_EXEC="/usr/lib/jvm/java-11-zulu-openjdk-jdk/bin/java"


echo "Descargando zip de autofirma..."
wget -q --show-progress "$URL_AF"

echo "Descargando rpm de java 11..."
wget -q --show-progress -O "$J11_RPM" "$URL_J11"

echo "Extrayendo RPM del zip..."
unzip -o "$ZIP_FILE"

# Busca el RPM dentro del directorio actual
AF_RPM=$(find . -maxdepth 1 -name "*.rpm" | head -n 1)

if [ -z "$AF_RPM" ]; then
  echo "No se encontró el archivo RPM dentro del zip."
  exit 1
else
  echo "RPM encontrado en el zip: $AF_RPM"
fi

echo "Instalando RPMs..."
sudo dnf install -y "$AF_RPM"
sudo dnf install -y "$J11_RPM"

echo "Limpiando archivos temporales..."
rm -f "$AF_FILE" "$AF_RPM" "$J11_RPM"

echo "Modificando ruta de Java para autofirma..."
sed -i "s|^Exec=.*|Exec=$NEW_EXEC|" "$DESKTOP_FILE"

echo "Proceso finalizado exitosamente."
