FROM eclipse-mosquitto:2.0.22

COPY ./config/mosquitto.conf /mosquitto/config/mosquitto.conf
COPY ./config/passwd.txt /mosquitto/config/passwd.txt
COPY ./config/acl.conf /mosquitto/config/acl.conf

RUN chmod 0700 /mosquitto/config/passwd.txt /mosquitto/config/acl.conf

EXPOSE 1883 9001
