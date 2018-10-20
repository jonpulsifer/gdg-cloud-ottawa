locals {
  # default region/zone
  region = "northamerica-northeast1"
  zone   = "northamerica-northeast1-a"
}

terraform {
  required_version = "~> 0.11.8"

  # terraform's state is held in gs://gdg-cloud-ottawa
  backend "gcs" {
    bucket         = "gdg-cloud-ottawa"
    prefix         = "terraform"
    project        = "gdg-cloud-ottawa"
    encryption_key = ""
  }
}

provider "google" {
  alias   = "ga"
  project = "${local.project}"
  region  = "${local.region}"
  zone    = "${local.zone}"
  version = "~> 1.19"
}

provider "google-beta" {
  alias   = "beta"
  project = "${local.project}"
  region  = "${local.region}"
  zone    = "${local.zone}"
  version = "~> 1.19"
}
