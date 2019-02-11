# Dockerfile with a USER directive
FROM node:7
ADD app.js /app.js
# Containers run from this image will run as user ID 5.
USER 5
ENTRYPOINT ["node", "app.js"]

