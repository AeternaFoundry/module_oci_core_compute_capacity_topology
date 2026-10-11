variable "core_compute_capacity_topologies" {
  description = <<EOT
Map of core_compute_capacity_topologies, attributes below
Required:
    - availability_domain
    - compartment_id
    - capacity_source (block):
        - capacity_type (required)
        - compartment_id (optional)
Optional:
    - defined_tags
    - display_name
    - freeform_tags
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    availability_domain = string
    compartment_id      = string
    defined_tags        = optional(map(string))
    display_name        = optional(string)
    freeform_tags       = optional(map(string))
    capacity_source = object({
      capacity_type  = string
      compartment_id = optional(string)
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.core_compute_capacity_topologies : (
        contains([for v in ["DEDICATED"] : lower(v)], lower(v.capacity_source.capacity_type))
      )
    ])
    error_message = "must be one of: \"DEDICATED\""
  }
}

