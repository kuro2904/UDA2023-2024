#!/bin/bash

echo server will start at port 8081

mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=8081

