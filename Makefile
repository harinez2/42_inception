COMPOSE_FILE	= ./srcs/docker-compose.yml

.PHONY: all
all: up

.PHONY: up
up:
	sudo docker compose -f $(COMPOSE_FILE) up -d --build

.PHONY: down
down:
	sudo docker compose -f $(COMPOSE_FILE) down

.PHONY: stop
stop: 
	sudo docker compose -f $(COMPOSE_FILE) stop

.PHONY: start
start: 
	sudo docker compose -f $(COMPOSE_FILE) start

.PHONY: ps
ps: 
	sudo docker container ps -a

.PHONY: prune
prune: 
	sudo docker compose -f $(COMPOSE_FILE) down --rmi all --volumes --remove-orphans
	sudo docker system prune -f

.PHONY: clean
clean: down

.PHONY: fclean
fclean: down prune

.PHONY: re
re: fclean all
