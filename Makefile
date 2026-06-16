name = Inception
all:
	@printf "Configuring ${name}...\\n"
	@if [ ! -d "/home/fracurul/data/" ]; then \
		mkdir -p /home/fracurul/data/; \
	fi
	@if [ ! -d "/home/fracurul/data/mariadb" ]; then \
		mkdir -p /home/fracurul/data/mariadb; \
	fi
	@if [ ! -d "/home/fracurul/data/wordpress" ]; then \
		mkdir -p /home/fracurul/data/wordpress; \
	fi
	@cp ./srcs/.env /home/fracurul/
	@/usr/local/bin/docker-compose -f ./srcs/docker-compose.yml --env-file /home/fracurul/.env up -d

build:
	@printf "Building ${name} configuration...\\n"
	@if [ ! -d "/home/fracurul/data/" ]; then \
		mkdir -p /home/fracurul/data/; \
	fi
	@if [ ! -d "/home/fracurul/data/mariadb" ]; then \
		mkdir -p /home/fracurul/data/mariadb; \
	fi
	@if [ ! -d "/home/fracurul/data/wordpress" ]; then \
		mkdir -p /home/fracurul/data/wordpress; \
	fi
	@/usr/local/bin/docker-compose -f ./srcs/docker-compose.yml --env-file /home/fracurul/.env up -d --build

down:
	@printf "Stopping ${name}...\\n"
	@/usr/local/bin/docker-compose -f ./srcs/docker-compose.yml --env-file /home/fracurul/.env down

clean: down
	@printf "Cleaning ${name}...\\n"
	@docker system prune -a
	@sudo chmod -R 777 /home/fracurul/data
	@sudo rm -rf /home/fracurul/data/wordpress/*
	@sudo rm -rf /home/fracurul/data/mariadb/*

fclean:
	@printf "Full cleaning ${name}...\\n"
	@sudo rm -rf /home/fracurul/data/mariadb/*
	@sudo rm -rf /home/fracurul/data/wordpress/*
	@sudo rm -rf /home/fracurul/data/*
	@sudo rm -rf /home/fracurul/data
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); fi
	@rm -f /home/fracurul/.env

re: fclean all

.PHONY	: all build down re clean fclean
