output "os_user" {
  description = "The OS user to be used"
  value       = "${module.dcos-windows-instances.admin_username}"
}

output "windows_passwords" {
  description = "Windows admin password"
  value       = ["${random_password.password.*.result}"]
}

output "num_windows_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
  value       = "${var.num_windows_agents}"
}

output "name_prefix" {
  description = "Name Prefix"
  value       = "${var.cluster_name}"
}

output "machine_type" {
  description = "Instance Type"
  value       = "${var.machine_type}"
}

output "zone_list" {
  description = "Element by zone list"
  value       = "${var.zone_list}"
}

output "image" {
  description = "Source image to boot from"
  value       = "${var.image}"
}

output "disk_type" {
  description = "Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional)"
  value       = "${var.disk_type}"
}

output "disk_size" {
  description = "Disk Size in GB"
  value       = "${var.disk_size}"
}

output "private_agent_subnetwork_name" {
  description = "Instance Subnetwork Name"
  value       = "${var.windows_agent_subnetwork_name}"
}

output "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  value       = "${var.user_data}"
}

output "os_user" {
  description = "The OS user to be used"
  value       = "${module.dcos-windows-instances.admin_username}"
}

output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${module.dcos-windows-instances.private_ips}"]
}

output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${module.dcos-windows-instances.public_ips}"]
}

output "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  value       = "${var.dcos_instance_os}"
}

output "scheduling_preemptible" {
  description = "Deploy instance with preemptible scheduling"
  value       = "${var.scheduling_preemptible}"
}

output "instances_self_link" {
  description = "List of instance self links"
  value       = ["${module.dcos-windows-instances.instances_self_link}"]
}

output "prereq-id" {
  description = "Returns the ID of the prereq script (if user_data or ami are not used)"
  value       = "${module.dcos-windows-instances.prereq_id}"
}