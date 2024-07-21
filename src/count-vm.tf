provider "yandex" {
  token     = "<your-yandex-cloud-token>"
  cloud_id  = "<your-cloud-id>"
  folder_id = "<your-folder-id>"
}

resource "yandex_compute_instance" "web" {
  count = 2

  name = "web-${count.index + 1}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8rj2ffqf7h9k0r9m9g"  # Замените на ID вашего образа
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

  # Назначение группы безопасности
  network_interface {
    subnet_id          = "<your-subnet-id>"
    security_group_ids = ["<your-security-group-id>"]
  }
}
