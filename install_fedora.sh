#!/bin/bash

URL_AF="https://firmaelectronica.gob.es/content/dam/firmaelectronica/descargas-software/AutoFirma_Linux_Fedora.zip"
URL_J11="https://cdn.azul.com/zulu/bin/zulu11.82.19-ca-jdk11.0.28-linux.x86_64.rpm"

AF_ZIP="AutoFirma_Linux_Fedora.zip"
AF_RPM="autofirma-1.*-*.noarch_FEDORA.rpm"
J11_RPM="zulu11.82.19-ca-jdk11.0.28-linux.x86_64.rpm"

DESKTOP_FILE="$HOME/.local/share/applications/autofirma.desktop"
NEW_EXEC="/usr/lib/jvm/java-11-zulu-openjdk-jdk/bin/java"


echo "Descargando zip de autofirma..."
wget -q --show-progress "$URL_AF"

echo "Extrayendo RPM del zip..."
unzip -o "$AF_ZIP"

AF_RPM=$(find . -maxdepth 1 -name $AF_RPM | head -n 1)

echo "Descargando rpm de java 11..."
wget -q --show-progress -O "$J11_RPM" "$URL_J11"

echo "Instalando RPMs..."
sudo dnf install -y "$AF_RPM"
sudo dnf install -y "$J11_RPM"

echo "Limpiando archivos temporales..."
rm -f "$AF_FILE" "$AF_RPM" "$J11_RPM"

echo "Modificando ruta de Java para autofirma..."
sed -i "s|^Exec=.*|Exec=$NEW_EXEC|" "$DESKTOP_FILE"

echo "Proceso finalizado exitosamente."
