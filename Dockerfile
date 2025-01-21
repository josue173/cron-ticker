
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
# Copia los archivos definidos al WORKING DIRECTORY
COPY package.json ./
# En la imagen no va la carpeta de node_modules, la cuál contiene las dependencias
# Como no se sube se tiene que correr el comando npm i, para reconstruir la carpeta o bien instalar las dependencias
# De quere más comandos se coloca &&
RUN npm install
# El primer punto quiere decir que copie en el path actual
# El segundo punto quiere decir que lo pege en el WORKING DIRECTORY (/app)
# El problema es que esto copia los módulos de node
COPY . .
# Relaizar prueba
RUN npm run test
# Eliminar el archivos y directorios innecesarios en PROD
# La r en -rf quiere decir que es recursivo, si hay directorios dentro de otros también los elimina
RUN rm -rf tests && rm -rf node_modules
# Reinstalando SOLO dependencias de PRODUCCIÓN
RUN npm install --prod
# Ejecutar comando para correr la aplicación
# Serie de instucciones a ejecutar
CMD ["node", "app.js"]