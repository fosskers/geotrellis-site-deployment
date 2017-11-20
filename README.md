GeoTrellis Site Deployment
=================================

This repo provides resources for deploying the core GeoTrellis Website
infrastructure. It follows Azavea's [Scripts to Rule Them
All](https://github.com/azavea/architecture/blob/master/doc/arch/adr-0000-scripts-to-rule-them-all.md)
format, and uses the [AWS CLI](https://aws.amazon.com/cli/) and [Terraform](https://www.terraform.io/) to drive deployment.

Deployment
----------

Create an AWS profile called `geotrellis-site`
```bash
aws --profile geotrellis-site configure
```

Create and provision the VM
```bash
$ ./scripts/setup
```

Use the `infra` script to deploy the website.

```console
export GT_SITE_SETTINGS_BUCKET="geotrellis-site-production-config-us-east-1"
./scripts/infra plan
./scripts/infra apply
```
