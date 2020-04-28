/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-private-agents/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-private-agents/job/master/)
 * # DC/OS Instances
 *
 * Creates DC/OS Private Agent intances
 *
 * ## Usage
 *
 *```hcl
 * module "dcos-windows-instances" {
 *   source = "dcos-terraform/windows-instance/gcp"
 *   version = "~> 0.2.0"
 *
 *   num_instance                   = "${var.instances_count}"
 *   disk_size                      = "${var.gcp_instances_disk_size}"
 *   disk_type                      = "${var.gcp_instances_disktype}"
 *   region                         = "${var.gcp_region}"
 *   machine_type                   = "${var.gcp_instances_gce_type}"
 *   cluster_name                   = "${var.cluster_name}"
 *   public_ssh_key                 = "${var.gcp_ssh_key}"
 *   instances_subnetwork_name      = "${module.network.instances_subnetwork_name}"
 *   instances_targetpool_self_link = "${module.network.instances_targetpool_self_link}"
 *   customer_image                 = "${var.image}"
 *   region                         = "${var.gcp_region}"
 *   zone_list                      = "${data.google_compute_zones.available.names}"
 *   admin_username                 = "${var.admin_username}"
 * }
 *```
 */

provider "google" {}

data "google_compute_image" "windows_image" {
  family  = "windows-1809-core-for-containers"
  project = "windows-cloud"
}

resource "random_password" "password" {
  count            = "${var.num_windows_agents}"
  length           = 32
  min_upper        = 1
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  special          = true
  override_special = "!@$%&*-_=+?"
}

module "dcos-windows-instances" {
  source = "dcos-terraform/instance/gcp"
  version = "~> 0.2.0"

  providers = {
    google = "google"
  }

  cluster_name             = "${var.cluster_name}"
  name_prefix              = "${var.name_prefix}"
  hostname_format          = "${var.hostname_format}"
  num_instances            = "${var.num_windows_agents}"
  image                    = "${coalesce(data.google_compute_image.windows_image.self_link, var.customer_image)}"
  user_data                = "${var.user_data}"
  machine_type             = "${var.machine_type}"
  instance_subnetwork_name = "${var.windows_agent_subnetwork_name}"
  public_ssh_key           = "${var.public_ssh_key}"
  ssh_user                 = "${var.ssh_user}"
  enable_windows_agents    = true
  admin_username           = "${var.admin_username}"
  admin_password_list      = ["${random_password.password.*.result}"]
  zone_list                = "${var.zone_list}"
  disk_type                = "${var.disk_type}"
  disk_size                = "${var.disk_size}"
  tags                     = "${var.tags}"
  dcos_instance_os         = "${var.dcos_instance_os}"
  scheduling_preemptible   = "${var.scheduling_preemptible}"
  guest_accelerator_type   = "${var.guest_accelerator_type}"
  guest_accelerator_count  = "${var.guest_accelerator_count}"

  labels = "${var.labels}"
}

/*resource "google_compute_instance" "winagent" {
  count        = "${var.num}"
  name         = "${format(var.hostname_format, count.index + 1, local.cluster_name)}"
  machine_type = "${local.machine_type}"
  project      = "${local.project}"
  zone         = "${local.zone}"

  "boot_disk" {
    initialize_params {
      image = "${coalesce(data.google_compute_image.windows_image.self_link, var.windows_image_link)}"
    }

    auto_delete = true
  }

  "network_interface" {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    sysprep-specialize-script-cmd = "winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms=\"1800000\"} & winrm set winrm/config/service @{AllowUnencrypted=\"true\"} & winrm set winrm/config/service/auth @{Basic=\"true\"} & powershell.exe -Command \"&{ $hostname = $(Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -URI 'http://metadata.google.internal/computeMetadata/v1/instance/hostname'); New-SelfSignedCertificate -DnsName $hostname -CertStoreLocation Cert:\\LocalMachine\\My; New-Item WSMan:\\localhost\\Listener -Address * -Transport HTTPS -HostName $hostname -CertificateThumbPrint $(ls Cert:\\LocalMachine\\My).Thumbprint -Force; Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False; Set-MpPreference -DisableRealtimeMonitoring $true; Enable-PSRemoting -Force }\""
    windows-startup-script-cmd    = "net user /add ${local.admin_username} \"${element(random_password.password.*.result, count.index)}\" /Y & net localgroup administrators ${local.admin_username} /add"
  }
}
*/