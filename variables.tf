variable "customer_image" {
  description = "GCP Windows image"
  default     = ""
}

variable "num_windows_agents" {
  description = "Specify the amount of private agents. These agents will provide your main resources"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "machine_type" {
  description = "Instance Type"
  default     = "n1-standard-2"
}

variable "zone_list" {
  description = "Element by zone list"
  type        = "list"
}

variable "image" {
  description = "Source image to boot from"
  default     = ""
}

variable "disk_type" {
  description = "Disk Type to Leverage The GCE disk type. Can be either 'pd-ssd', 'local-ssd', or 'pd-standard'. (optional)"
  default     = "pd-ssd"
}

variable "disk_size" {
  description = "Disk Size in GB"
  default     = "120"
}

variable "windows_agent_subnetwork_name" {
  description = "Instance Subnetwork Name"
}

variable "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

variable "ssh_user" {
  description = "SSH User"
}

variable "public_ssh_key" {
  description = "SSH Public Key"
}

variable "admin_username" {
  description = "Windows Admin User"
  default = "Administrator"
}

variable "admin_password" {
  description = "Windows Admin Password"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "list"
  default     = []
}

variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "%[3]s-winagt%[1]d-%[2]s"
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  default     = "windows_1809"
}

variable "scheduling_preemptible" {
  description = "Deploy instance with preemptible scheduling"
  default     = false
}

variable "guest_accelerator_type" {
  description = "Type of guest accelerator"
  default     = "nvidia-tesla-k80"
}

variable "guest_accelerator_count" {
  description = "Count of guest accelerator type"
  default     = 0
}

variable "labels" {
  description = "Add custom labels to all resources"
  type        = "map"
  default     = {}
}

variable "name_prefix" {
  description = "Name Prefix"
  default     = ""
}