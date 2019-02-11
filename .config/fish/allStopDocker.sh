#!/bin/bash

docker stop $(docker ps -a -q) 
docker rm $(docker ps -a -q)
docker system prune
docker volume rm $(docker volume ls -q)
docker ps
docker images
