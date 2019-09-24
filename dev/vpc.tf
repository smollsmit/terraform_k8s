resource "google_compute_network" "vpc" {                                                                                                                                                                   
  name                    =  "${format("%s","${var.project}-${var.env}-vpc")}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}