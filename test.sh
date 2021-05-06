docker build -t ft_server .
docker run -it --rm -p 80:80 -p 443:443 ft_server
