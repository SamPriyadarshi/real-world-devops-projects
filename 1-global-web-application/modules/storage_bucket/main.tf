resource "google_storage_bucket" "default" {
  name     = var.bucket_name
  project  = var.project_id
  location = var.bucket_location
  force_destroy = var.force_destroy
}

resource "google_storage_bucket_object" "default" {
  for_each = var.files
  name     = each.key
  source   = each.value
  bucket   = google_storage_bucket.default.name
}
