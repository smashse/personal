terraform {
  required_version = ">= 1.0.4"
  backend "s3" {
    bucket                      = "terraform-state-oci-example-vin-shr"
    key                         = "terraform-heml-oke-example-vin-dev.tfstate"
    region                      = "sa-vinhedo-1"
    endpoint                    = "https://example.compat.objectstorage.sa-vinhedo-1.oraclecloud.com"
    force_path_style            = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    shared_credentials_file     = "~/.aws/credentials_example"
  }
}