### ETAPA DE INSTALACIÓN DE DEPENDENCIAS - PRIMERA ETAPA - PRIMER STAGE ###
# Por lo general el código estará basado en otra imagen
# FROM es la imagen raíz, el punto de inicio
# FROM node:19.2-alpine3.16 
# --platform=linux/amd64 ES PARA UNA PLATAFORMA EN ESPECÍFICO
# Para M1 y M2 respectivamente
# FROM --platform=linux/amd64 node:19.2-alpine3.16
# --platform=$BUILDPLATFORM Esta imagen en particular dependerá de las plataformas que la variable de entorno provea
# El nombre del stage se define con " as dependencies "
FROM node:19.2-alpine3.16 as dependencies
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


# CADA FROM INDICARÁ QUE ES UNA NUEVA ETAPA
# Siempre se inicia a trabajar como si estuvieramos iniciando de nuevo, por eso el WORKDIR /app y demás...
# DEPENDENCIAS DE PRODUCCIÓN
FROM node:19.2-alpine3.16 as prod-dependencies
WORKDIR /app
COPY package.json ./
RUN npm install --prod


FROM node:19.2-alpine3.16 as tester-builder
WORKDIR /app
# Hago referencia a la etapa anterior con el "--from" y marco como destino "./node_modules"
COPY --from=dependencies /app/node_modules ./node_modules
# Copia el directorio en el que se encuentra acutalmente y lo pega al linux que estoy creando
COPY . . 
# Ejecuto el test
RUN npm run test


# CORRER LA APLICACION
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-dependencies /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks
# Ejecutar comando para correr la aplicación
# Serie de instucciones a ejecutar
CMD ["node", "app.js"]