.SILENT: infra start test
.PHONY: infra start test

infra:
	docker network create weather || true
	cp docker/.env-example docker/.env
	cp .env-example .env
	cd docker && docker-compose up -d --build
	echo "Finish ✅"

test:
	docker exec -u dev bank_slip_app bash -c "coverage=true rspec -fd spec"

start:
	make infra