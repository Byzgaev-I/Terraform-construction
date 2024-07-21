provider "yandex" {
  token     = "y0_AgAAAAAAqYCBAATuwQAAAAEKezjYAADtzaLyKlNM7Z0e4gbif4KWCNHUjw"
  cloud_id  = "b1g31ab21b32dog1ps4c"
  folder_id = "b1gam4o6rj97es4peaq4"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "web" {
  count = 2

  name = "web-${count.index + 1}"

  depends_on = [yandex_compute_instance.db]

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id          = "<your-subnet-id>"
    nat                = true
    security_group_ids = ["<your-security-group-id>"]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}
