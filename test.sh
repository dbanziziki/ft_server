#!/bin/
docker build -t ft_server . 
docker run --rm --name ft_server -d -p 80:80 -p 443:443 ft_server
