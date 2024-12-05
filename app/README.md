# WORDPRESS APP

This is to illustrate a CI pipeline for Wordpress development.

## Development

The custom code would be place under `./custom-plugin` and `./custom-theme`. Then the github actions workflow builds, test and publishes the container based on the `Dockerfile`.

## Workflow Description

The Github workflow watches any commit to the `/app/*` directory on the `main` branch. And executed the operations described bellow by the cli equivalents.

### Log into Amazon ECR

- CLI equivalent:

```
aws ecr get-login-password | docker login --username AWS --password-stdin 881490094297.dkr.ecr.eu-west-1.amazonaws.com
```

### Build the docker container

- CLI equivalent:
  
```
docker build -t 881490094297.dkr.ecr.eu-west-1.amazonaws.com/topcon-challenge-dev:<GH_HASH> .
```

### Push the image to ECR

- Push the image to repo

```
docker push 881490094297.dkr.ecr.eu-west-1.amazonaws.com/topcon-challenge-dev:<GH_HASH>
```