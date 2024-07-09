docker swarm init
docker build -t homepedia_app:latest ./app/
docker stack deploy -c docker-stack.yml homepedia



docker stack rm homepedia

# docker compose -f "docker-compose.yml" up -d --build