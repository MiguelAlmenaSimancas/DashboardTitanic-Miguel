# Etapa de build: construye la aplicación Svelte
FROM node:18-alpine AS build
WORKDIR /app

# Copia los archivos de dependencias y los instala
COPY package*.json ./
RUN npm install

# Copia el resto del código y lo compila
COPY . .
RUN npm run build

# Etapa de producción: utiliza Nginx para servir la aplicación compilada
FROM nginx:alpine

# --> Agregamos este paso para asegurarnos de que el entrypoint de Nginx tenga permisos de ejecución.
# Esto es útil en entornos donde los permisos pudieran haberse modificado.
RUN chmod +x /docker-entrypoint.sh

# Copia el contenido compilado de la etapa anterior al directorio que Nginx usa para servir archivos estáticos
COPY --from=build /app/dist /usr/share/nginx/html

# Expone el puerto 80 para acceder a la aplicación
EXPOSE 80

# Comando por defecto para iniciar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]