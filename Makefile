# Colors for output
GREEN = \033[0;32m
BLUE = \033[0;34m
RED = \033[0;31m
YELLOW = \033[0;33m
NC = \033[0m

COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /Users/$(USER)/data

$(DATA_DIR)/mariadb:
	mkdir -p $(DATA_DIR)/mariadb
$(DATA_DIR)/wordpress:
	mkdir -p $(DATA_DIR)/wordpress

help:
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  $(GREEN)make up$(NC)          - Start containers"
	@echo "  $(GREEN)make down$(NC)        - Stop containers"
	@echo "  $(GREEN)make re$(NC)          - Restart containers (down + up)"
	@echo "  $(GREEN)make restart$(NC)     - Quick restart of running containers"
	@echo "  $(GREEN)make logs$(NC)        - Show container logs"
	@echo "  $(GREEN)make clean$(NC)       - Remove containers and images"
	@echo "  $(GREEN)make fclean$(NC)      - Remove everything including volumes"
	@echo "  $(GREEN)make help$(NC)        - Show this help message"

build: $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	docker-compose -f $(COMPOSE_FILE) build

up: build
	@echo "$(YELLOW)Starting containers..$(NC)"
	docker-compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)✓ Containers started!$(NC)"
	@echo "$(BLUE)Access your site at: https://kmaeda.42.fr$(NC)"

all: build up

down:
	@echo "$(YELLOW)Stopping containers..$(NC)"
	docker-compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)✓ Containers stopped!$(NC)"

re: down up
	@echo "$(GREEN)✓ Containers restarted!$(NC)"

restart:
	@echo "$(YELLOW)Restarting containers..$(NC)"
	docker-compose -f $(COMPOSE_FILE) restart
	@echo "$(GREEN)✓ Containers restarted!$(NC)"

logs:
	@echo "$(YELLOW)Showing logs..$(NC)"
	docker-compose -f $(COMPOSE_FILE) logs -f

clean:
	@echo "$(YELLOW)Removing containers and images..$(NC)"
	docker-compose -f $(COMPOSE_FILE) down --rmi all
	@echo "$(GREEN)✓ All containers and images cleaned!$(NC)"

fclean: clean
	@echo "$(RED)WARNING: This will remove all data including volumes!$(NC)"
	@printf "Are you sure? [y/N] "; \
	read answer; \
	case "$$answer" in \
		y|Y|yes|YES) \
			docker-compose -f $(COMPOSE_FILE) down -v --rmi all; \
			sudo rm -rf $(DATA_DIR)/wordpress/* $(DATA_DIR)/mariadb/* || true; \
			echo "$(GREEN)✓ Full clean completed!$(NC)" ;; \
		*) \
			echo "$(BLUE)Cancelled$(NC)" ;; \
	esac

.PHONY: all build up down re restart logs clean fclean

.DEFAULT_GOAL := help
