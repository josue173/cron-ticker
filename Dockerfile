
# Por lo general el código estará basado en otra imagen
# FROM es la imagen raíz, el punto de inicio
FROM node:19.2-alpine3.16 
# /app, esa es la carpeta en la que suele ponerse la imagen
# Este comando es como hacer un cd..
# La carpeta /app ya viene en Linux, las versiones alpaine son para linux
WORKDIR /app
# FUNTE, DESTINO - En este caso son los archivos que quiero 
# poner en la imagen y el destino
# como escribí el comando WORKDIR puedo usar: ./
# Pero de no haberlo hecho tendría que haber puesto: /app/
COPY app.js package.json ./
# En la imagen no va la carpeta de node_modules, la cuál contiene las dependencias
# Como no se sube se tiene que correr el comando npm i, para reconstruir la carpeta o bien instalar las dependencias
# De quere más comandos se coloca &&
RUN npm install
# Ejecutar comando para correr la aplicación
# Serie de instucciones a ejecutar
CMD ["node", "app.js"]