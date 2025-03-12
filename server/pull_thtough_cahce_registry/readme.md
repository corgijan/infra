### create new users via:

htpasswd -B htpasswd $USER

### collect garbage via 
docker-compose -f [path_to_your_docker_compose_file] run registry bin/registry garbage-collect /etc/docker/registry/config.yml
