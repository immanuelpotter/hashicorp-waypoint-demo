#!/bin/bash
container_id=$(docker ps | awk '/5000/{print $1}')
docker stop $container_id && docker rm $_
