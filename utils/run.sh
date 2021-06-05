#!/bin/bash
docker build -t flask-app:latest .
docker run -d -p 5000:5000 flask-app:latest
