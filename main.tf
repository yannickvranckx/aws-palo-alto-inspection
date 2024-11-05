#Set the provider and your default tags
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      created_with = "terraform"
      created_by   = "yannick.vranckx.ext@luminus.be"
      description  = "aws-network"
      map-migrated = "mig39446"
      gitlab_repo = "gitlab.com/luminusbe/network/aws-palo-alto-inspection/"
    }
  }
}
