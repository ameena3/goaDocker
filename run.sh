#!/bin/sh
docker rm goaimage 
docker build --rm . -t goaimage
docker run -it -p 8000:8000 --name goaimage goaimage 