resource "vultr_kubernetes" "k8" {
  region  = "ewr"
  label   = "tf-test"
  version = "v1.20.11+2"

  node_pools {
    node_quantity = 1
    plan = "vc2-2c-4gb"
    label = "my-label"
  }
}
