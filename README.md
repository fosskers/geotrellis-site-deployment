# GeoTrellis Site Deployment

This repository provides the resources for deploying the core GeoTrellis Website
infrastructure. It follows Azavea's [Scripts to Rule Them
All](https://github.com/azavea/architecture/blob/master/doc/arch/adr-0000-scripts-to-rule-them-all.md)
format, and uses [Terraform](https://www.terraform.io/) to drive deployments.

Deployment
----------

Create an AWS profile called `geotrellis-site`:

```bash
aws --profile geotrellis-site configure
```

From there, instantiate the Terraform container image and use the `infra` script to deploy the base infrastructure:

```console
$ docker-compose run --rm terraform
bash-4.3# ./scripts/infra plan
bash-4.3# ./scripts/infra apply
```
