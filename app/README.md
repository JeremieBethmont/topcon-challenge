# WORDPRESS APP

## Build the docker container

- Docker build
docker build . -t topcon-wordpress

## Push to ECR
- Log docker into ecr repo
aws ecr get-login-password | docker login --username AWS --password-stdin 881490094297.dkr.ecr.eu-west-1.amazonaws.com

- Tag the image for ECR
docker tag topcon-wordpress:latest 881490094297.dkr.ecr.eu-west-1.amazonaws.com/topcon-challenge-dev:latest

- Push the image to repo
docker push 881490094297.dkr.ecr.eu-west-1.amazonaws.com/topcon-challenge-dev:latest