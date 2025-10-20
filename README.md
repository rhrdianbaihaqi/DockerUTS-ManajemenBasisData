# UTS Manajemen Basis Data

## Disusun Oleh 

* **Nama** : Muhammad Rahardian Baihaqi
* **NIM** : 1237050023
* **Kelas** : MBD-C
* **Mata Kuliah** : Manajemen Basis Data

---

## Teknologi yang Digunakan

Proyek ini dibuat dan dikelola menggunakan beberapa teknologi utama:

![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-2C568A?style=for-the-badge&logo=pgadmin&logoColor=white)
![DBeaver](https://img.shields.io/badge/DBeaver-38322E?style=for-the-badge&logo=dbeaver&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/VSCode-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)

---

## Cara Menjalankan Proyek

Karena proyek ini menggunakan Docker, Anda dapat menjalankannya dengan langkah-langkah berikut:

1.  **Clone repositori ini:**
    ```bash
    git clone [https://www.andarepository.com/](https://www.andarepository.com/)
    cd [nama-folder-proyek]
    ```

2.  **Build dan jalankan container Docker:**
    (Pastikan Anda sudah memiliki file `docker-compose.yml`)
    ```bash
    docker-compose up -d --build
    ```

3.  **Akses Aplikasi:**
    Aplikasi sekarang seharusnya berjalan di `http://localhost:[port-host]`.

4.  **Akses Database:**
    Anda dapat terhubung ke database PostgreSQL menggunakan **DBeaver** atau **pgAdmin** dengan detail koneksi yang ada di file `docker-compose.yml` or `.env` Anda (misalnya, host: `localhost`, port: `5432`).

---
