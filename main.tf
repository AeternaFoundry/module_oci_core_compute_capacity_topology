resource "oci_core_compute_capacity_topology" "core_compute_capacity_topologies" {
  for_each = var.core_compute_capacity_topologies

  availability_domain = each.value.availability_domain
  compartment_id      = each.value.compartment_id
  defined_tags        = each.value.defined_tags
  display_name        = each.value.display_name
  freeform_tags       = each.value.freeform_tags

  capacity_source {
    capacity_type  = each.value.capacity_source.capacity_type
    compartment_id = each.value.capacity_source.compartment_id
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

