build:
	sudo docker-compose build

deploy:
	sudo docker-compose up -d

stop:
	sudo docker-compose down

restart:
	sudo docker-compose down
	sudo docker-compose up -d

build-mosquitto:
	sudo docker-compose build mosquitto

deploy-mosquitto:
	sudo docker-compose up -d mosquitto

stop-mosquitto:
	sudo docker-compose down mosquitto

restart-mosquitto:
	sudo docker-compose down mosquitto
	sudo docker-compose up -d mosquitto
