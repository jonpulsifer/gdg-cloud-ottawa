locals {
  billing_account = "009BE0-2F835F-F20651"
  organization    = "organizations/5046617773"
  project         = "gdg-cloud-ottawa"
}

/* Top level folder that holds our projects
Ref: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy#folders */
resource "google_folder" "gdg-cloud-ottawa" {
  display_name = "GDG Cloud Ottawa"
  parent       = "${local.organization}"
}

/* IAM policy for the GDG Cloud Ottawa folder
Ref: https://cloud.google.com/resource-manager/docs/access-control-folders */
resource "google_folder_iam_policy" "gdg-cloud-ottawa" {
  policy_data = "${data.google_iam_policy.folder-gdg-cloud-ottawa.policy_data}"
  folder      = "${google_folder.gdg-cloud-ottawa.name}"
}

data "google_iam_policy" "folder-gdg-cloud-ottawa" {
  binding {
    members = ["user:jonathan@pulsifer.ca"]
    role    = "roles/resourcemanager.folderAdmin"
  }
}

/* gdg-cloud-ottawa project implemented using a terraform module
Ref: https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy#projects */
module "project" {
  source          = "modules/gcp-project"
  name            = "gdg-cloud-ottawa"
  billing_account = "${local.billing_account}"
  project_id      = "${local.project}"
  folder_id       = "${google_folder.gdg-cloud-ottawa.id}"
}

/* IAM policy for the gdg-cloud-ottawa project
Ref: https://cloud.google.com/resource-manager/docs/access-control-proj */
resource "google_project_iam_policy" "gdg-cloud-ottawa" {
  policy_data = "${data.google_iam_policy.admin.policy_data}"
}

data "google_iam_policy" "admin" {
  binding {
    members = ["serviceAccount:service-631282479344@compute-system.iam.gserviceaccount.com"]
    role    = "roles/compute.serviceAgent"
  }

  binding {
    members = ["serviceAccount:631282479344-compute@developer.gserviceaccount.com", "serviceAccount:631282479344@cloudservices.gserviceaccount.com"]
    role    = "roles/editor"
  }

  binding {
    members = ["user:jonathan@pulsifer.ca"]
    role    = "roles/owner"
  }
}

/* List of APIs or services enabled on the gdg-cloud-ottawa project
Ref: https://cloud.google.com/apis/docs/overview */
resource "google_project_services" "gdg-cloud-ottawa" {
  services = []
}
