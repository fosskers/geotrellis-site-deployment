data "terraform_remote_state" "gt-site-cluster" {
  backend = "s3"

  config {
    bucket = "aws-state"
    key    = "geotrellis-site/gt-site-cluster.tfstate"
    region = "us-east-1"
  }
}
