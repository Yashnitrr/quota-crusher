//Service Account files path must be updated in the following variable
locals {
  service_account = "../config/service_account.json"
}

provider "google" {
  credentials = "${file("${local.service_account}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
