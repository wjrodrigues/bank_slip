.SILENT: infra start
.PHONY: infra start

infra:
	docker network create weather || true
	cp docker/.env-example docker/.env
	cp .env-example .env
	cd docker && docker-compose up -d --build
	echo "Finish ✅"

start:
	make infra