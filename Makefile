# SmartShop Docker Management Makefile
.PHONY: help build run dev prod down clean logs test status

# Default target
.DEFAULT_GOAL := help

# Colors for output
GREEN=\033[0;32m
YELLOW=\033[1;33m
RED=\033[0;31m
NC=\033[0m # No Color

help: ## 📚 Bu yardım mesajını gösterir
	@echo "${GREEN}🚀 SmartShop Docker Management${NC}"
	@echo "${YELLOW}Available commands:${NC}"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## 🏗️  Docker image'larını build et
	@echo "${GREEN}Building Docker images...${NC}"
	docker-compose build --no-cache
	@echo "${GREEN}✅ Build completed!${NC}"

run: prod ## 🚀 Production ortamında çalıştır (alias for prod)

prod: ## 🏭 Production ortamında çalıştır
	@echo "${GREEN}Starting SmartShop in production mode...${NC}"
	docker-compose up -d
	@echo "${GREEN}✅ Production environment started!${NC}"
	@echo "${YELLOW}🌐 Backend API: http://localhost:8080${NC}"
	@echo "${YELLOW}🗄️  Database: localhost:5432${NC}"

dev: ## 🛠️  Development ortamında çalıştır
	@echo "${GREEN}Starting SmartShop in development mode...${NC}"
	docker-compose -f docker-compose.dev.yml up -d
	@echo "${GREEN}✅ Development environment started!${NC}"
	@echo "${YELLOW}🌐 Dev Backend API: http://localhost:8081${NC}"
	@echo "${YELLOW}🗄️  Dev Database: localhost:5433${NC}"

down: ## 🛑 Container'ları durdur
	@echo "${YELLOW}Stopping containers...${NC}"
	docker-compose down
	docker-compose -f docker-compose.dev.yml down
	@echo "${GREEN}✅ Containers stopped!${NC}"

clean: ## 🧹 Tüm container'ları ve volume'ları temizle
	@echo "${YELLOW}Cleaning up Docker resources...${NC}"
	docker-compose down -v --remove-orphans
	docker-compose -f docker-compose.dev.yml down -v --remove-orphans
	docker system prune -f
	@echo "${GREEN}✅ Cleanup completed!${NC}"

logs: ## 📋 Backend loglarını göster
	@echo "${GREEN}Showing backend logs...${NC}"
	docker-compose logs -f backend

logs-dev: ## 📋 Development backend loglarını göster
	@echo "${GREEN}Showing development backend logs...${NC}"
	docker-compose -f docker-compose.dev.yml logs -f backend-dev

status: ## 📊 Container durumlarını göster
	@echo "${GREEN}📊 Container Status:${NC}"
	@echo "${YELLOW}Production containers:${NC}"
	docker-compose ps
	@echo "${YELLOW}Development containers:${NC}"
	docker-compose -f docker-compose.dev.yml ps
	@echo "${YELLOW}Docker images:${NC}"
	docker images | grep smartshop

test: ## 🧪 Container içinde testleri çalıştır
	@echo "${GREEN}Running tests in container...${NC}"
	docker-compose exec backend npm test

test-build: ## 🧪 Test için container build et ve çalıştır
	@echo "${GREEN}Building and testing container...${NC}"
	cd Back-End/SmartShop-Server && docker build -t smartshop-test .
	docker run --rm smartshop-test npm test

health: ## 🏥 Container'ların health check'ini yap
	@echo "${GREEN}Checking container health...${NC}"
	docker-compose ps
	@echo "${YELLOW}Testing API endpoints...${NC}"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/api/products && echo " ✅ Production API is healthy" || echo " ❌ Production API is down"
	@curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/api/products && echo " ✅ Development API is healthy" || echo " ❌ Development API is down"

rebuild: ## 🔄 Container'ları yeniden build et ve başlat
	@echo "${GREEN}Rebuilding and restarting...${NC}"
	make down
	make build
	make prod

demo: ## 🎬 Demo için hızlı başlatma
	@echo "${GREEN}🎬 Starting demo environment...${NC}"
	make clean
	make build
	make prod
	@sleep 10
	@echo "${GREEN}✅ Demo ready!${NC}"
	@echo "${YELLOW}🌐 API Test: curl http://localhost:8080/api/products${NC}"
