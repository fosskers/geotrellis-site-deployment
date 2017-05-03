GeoTrellis Site + Demo Deployment
=================================

This über repo provides configuration for deploying the GeoTrellis website
and its associated demos. It follows Azavea's [Scripts to Rule Them
All](https://github.com/azavea/architecture/blob/master/doc/arch/adr-0000-scripts-to-rule-them-all.md)
format, but also includes a `Makefile` and Terraform config for testing and
deployment respectively.

The current cluster is comprised of four containers:

- `gtsite-nginx`: serves static assets and redirects API calls meant for the
other containers
- `gtsite-service`: produces results for the Weighted Overlay and Hillshade mini-demos
- `gt-transit`: produces results for the Transit mini-demo. Also is its own standalone demo
available at `transit/`
- `gt-chatta-demo`: A standalone demo available at `chatta/`

Development
-----------

### Environment Setup
Create an AWS profile called `geotrellis-site`
```bash
aws --profile geotrellis-site configure
```

Create and provision the VM
```bash
$ ./scripts/setup
```

### Git Submodules
This repo utilizes [Git Submodules](https://git-scm.com/docs/git-submodule). To properly
clone the repo, run:

```console
git clone --recursive <cloning-url>
```

Once cloned, the available commands are as follows:

Command | Effect
------- | ------
`make setup` | One-time fetch of Transit data + Chatta data ingest
`make build` | Build static assets + assemble fat JARs
`make clean` | Delete assets + assembled JARs
`make images` | Build docker images
`make up` | Run a `docker-compose` cluster (access via `localhost:8080`)
`make down` | Same as `docker-compose down`
`make publish` | Publish docker images to remote repo

**Notes:**
- `make build` will always tag each newly built image with the latest commit
hash
- `make publish` will always push this latest tagged version, as well as
`latest`

Deployment
----------

Deployment is driven by Terraform. To deploy the website, ssh into the VM and do:

```console
export GT_SITE_SETTINGS_BUCKET="geotrellis-site-staging-config-us-east-1"
./scripts/infra plan
./scripts/infra apply
```
