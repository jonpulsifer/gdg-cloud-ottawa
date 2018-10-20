/* GCS bucket that holds our terraform state
Ref: https://cloud.google.com/storage/docs */
resource "google_storage_bucket" "gdg-cloud-ottawa" {
  name     = "gdg-cloud-ottawa"
  location = "northamerica-northeast1"
}

/* IAM policy for the gdg-cloud-ottawa bucket
Ref: https://cloud.google.com/storage/docs/access-control/iam-reference */
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = "gdg-cloud-ottawa"
  role   = "roles/storage.admin"

  members = [
    "user:jonathan@pulsifer.ca",
  ]
}
