resource "aws_eks_node_group" "monitoring-logging" {
  cluster_name    = var.cluster_name
  node_group_name = "monitoring-logging"
  node_role_arn   = "arn:aws:iam::255411255437:role/nailbiter-prod-node-group-policy"
  subnet_ids      = ["subnet-001f8c036836577d7"]
  
  launch_template {
    id      = aws_launch_template.monitoring-logging.id
    version = "$Latest"
  }

  taint {
    key    = "Monitoring"
    value  = "Yes"
    effect = "NO_SCHEDULE"
  }

  labels = {
    Monitoring = "Yes"
  }

  ami_type       = "AL2_ARM_64"
  
  #remote_access {
    #ec2_ssh_key = "Nailbiter-prod-eks-key"
  #}  

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
 # depends_on = [
 #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
 #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
 #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
 # ]
}


data "template_file" "backendapp_launch_template_userdata" {
  template = file("template/userdata.tpl")

  vars = {
    cluster_name        = var.cluster_name
    endpoint            = var.cluster_endpioint
    cluster_auth_base64 = var.cluster_auth_base64

    bootstrap_extra_args = ""
    kubelet_extra_args   = ""
  }
}


resource "aws_launch_template" "monitoring-logging" {
  name_prefix   = "monitoring-logging-lt"
  description   = "monitoring new launch template"
  instance_type = "t4g.medium"
  key_name = "Nailbiter-prod-eks-key"
  
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50
      volume_type = "gp3"
      delete_on_termination = true
      encrypted = true
      kms_key_id = "arn:aws:kms:us-west-2:255411255437:key/7ac4f0fe-bb64-401d-b5f4-84de455ca8ed"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = ["sg-006f0fa9480aa84b8"] # Specify your security group IDs
    #subnet_id                   = "subnet-001f8c036836577d7"        # Specify your subnet ID
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "monitoring-logging",
      ManagedBy ="Terraform",
      Environment = "Production"
    }
  }
}
