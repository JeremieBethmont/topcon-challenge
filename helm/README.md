# WORDPRESS DEPLOYMENT WITH HELM 

The helm directory is the illustration of a repository containing helm charts for deploying docker applications on kubernetes. In a real production environment this should be stored under a dedicated repo.

## Helm Install

The TF code automates the following helm command:

```
helm install topcon-challenge \
  --set global.defaultStorageClass=gp2 \
  --set wordpressUsername=admin \
  --set wordpressPassword=password \
  --set mariadb.auth.rootPassword=secretpassword \
  --set image.registry=881490094297.dkr.ecr.eu-west-1.amazonaws.com \
  --set image.repository=topcon-challenge-dev \
  --set image.tag=b483060b16420825cb72bba5135966c800d70dac \
    oci://registry-1.docker.io/bitnamicharts/wordpress
```

- `global.defaultStorageClass=gp2`: sets the storage class to gp2 (no default on cluster)
- `wordpressUsername`: sets a dummy wp username
- `wordpressPassword`: sets a dummy wp password
- `mariadb.auth.rootPassword`: sets a dummy mariaDB password
- `image.registry`: pulls the image from private ECR registry
- `image.repository`: name of the repository where the custom image is stored
- `image.tag`: tag of the custom image to deploy

