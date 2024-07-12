#!/bin/sh
if [ $# -eq 0 ]; then
    echo "No given argument."
    exit 1
fi

argument=$1
app_folder_path="../../homepedia-app/"
export $(cat ../.env) > /dev/null 2>&1

if [ "$argument" = "-i" ]; then
    echo "Deployment initialization..."
    docker swarm init
    docker build -t homepedia_app:latest $app_folder_path
    docker stack deploy -c ../docker-stack.yml homepedia
elif [ "$argument" = "-u" ]; then
    lockfile=".deployment_lockfile"
    locked_kwd="locked"
    unlocked_kwd="unlocked"

    if grep -q $unlocked_kwd $lockfile; then
        echo $locked_kwd > $lockfile

        old_app_container_id=$(docker ps --filter "name=homepedia_app" --format "{{.ID}}" | head -n1)
        echo "Deployment update..."
        docker build -t homepedia_app:latest $app_folder_path
        docker service update --replicas 2 homepedia_app
        docker container stop $old_app_container_id
        docker container rm $old_app_container_id
        docker service update --replicas 1 homepedia_app

        echo $unlocked_kwd > $lockfile
    else
        echo "Deployment already in progress"
    fi
elif [ "$argument" = "-r" ]; then
    echo "Remove all services..."
    docker stack rm homepedia
else
    echo "Unknown arg : $argument. Use 'i' to initialize deployment or 'u' to update deployment."
    exit 1
fi