TAG     := $(shell git rev-parse --short HEAD)
SERVER  := fosskers/gtsite-service
NGINX   := fosskers/gtsite-nginx
TRANSIT := fosskers/gt-transit
CHATTA  := fosskers/gt-chatta-demo

clean:
	cd geotrellis-site && make clean
	cd geotrellis-chatta-demo && make clean
	cd geotrellis-transit && ./sbt clean

# One-time data fetches/ingests
setup: chatta
	cd geotrellis-transit && make fetch
	cd geotrellis-chatta-demo && make ingest-docker

site:
	cd geotrellis-site && make assets && make assembly

transit:
	cd geotrellis-transit && ./sbt assembly

chatta:
	cd geotrellis-chatta-demo && make build

build: site transit chatta

images:
	docker-compose build
	docker tag ${SERVER}  ${SERVER}:${TAG}
	docker tag ${NGINX}   ${NGINX}:${TAG}
	docker tag ${TRANSIT} ${TRANSIT}:${TAG}
	docker tag ${CHATTA}  ${CHATTA}:${TAG}

publish:
	docker push ${SERVER}:${TAG}
	docker push ${NGINX}:${TAG}
	docker push ${TRANSIT}:${TAG}
	docker push ${CHATTA}:${TAG}
	docker push ${SERVER}:latest
	docker push ${NGINX}:latest
	docker push ${TRANSIT}:latest
	docker push ${CHATTA}:latest

up:
	docker-compose -f docker-compose.yml up

down:
	docker-compose -f docker-compose.yml down
