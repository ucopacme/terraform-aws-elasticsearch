locals {
  enabled = var.enabled == "true"
}
resource "aws_elasticsearch_domain" "this" {
  count = local.enabled ? 1 : 0

  # fix this!
  # advanced_options = var.advanced_options

  advanced_security_options {
    enabled                        = var.advanced_security_options
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_arn      = var.master_user_arn
      master_user_name     = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  cluster_config {
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_type
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    warm_count               = var.warm_count
    warm_enabled             = var.warm_enabled
    warm_type                = var.warm_type
    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }
    zone_awareness_enabled = var.zone_awareness_enabled
  }

  cognito_options {
    enabled          = var.cognito_options
    identity_pool_id = var.cognito_options == true ? var.identity_pool_id : ""
    role_arn         = var.role_arn
    user_pool_id     = var.user_pool_id
  }

  domain_name = var.domain_name

  domain_endpoint_options {
    enforce_https       = var.enforce_https
    tls_security_policy = var.tls_security_policy
  }

  ebs_options {
    ebs_enabled = var.ebs_enabled
    iops        = var.iops
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  elasticsearch_version = var.elasticsearch_version

  encrypt_at_rest {
    enabled    = var.encrypt_at_rest
    kms_key_id = var.kms_key_id
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
    enabled                  = var.log_publishing_options
    log_type                 = var.log_type
  }

  node_to_node_encryption {
    enabled = var.node_to_node_encryption
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  tags = merge(var.tags, map("Name", var.name))

  vpc_options {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
}
