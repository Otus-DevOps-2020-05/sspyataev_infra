provider "yandex" {
  token     = "AgAAAAAB33xqAATuwbOe9FqhyUZfsVDN0f9B0VM"
  cloud_id  = "b1ghh6cur846mt52a54q"
  folder_id = "b1gtaiq9bg16fibnrlns"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = "fd82vj8e8h7cp5ep3onp"
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = "e9bnccj33rudeal9874s"
    nat       = true
  }
}
