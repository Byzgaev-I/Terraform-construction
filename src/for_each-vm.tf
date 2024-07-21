variable "each_vm" {
  type = list(object({
    vm_name    = string
    cpu        = number
    ram        = number
    disk_volume = number
  }))
}

locals {
  each_vm = [
    {
      vm_name    = "main"
      cpu        = 2
      ram        = 4
      disk_volume = 50
    },
    {
      vm_name    = "replica"
      cpu        = 1
      ram        = 2
      disk_volume = 25
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each = { for vm in local.each_vm : vm.vm_name => vm }

  name = each.value.vm_name

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = "fd8rj2ffqf7h9k0r9m9g"  # Замените на ID вашего образа
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = "<your-subnet-id>"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
