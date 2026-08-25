# 🚗 Sistem Manajemen Transportasi Online

## 📌 Deskripsi

**Sistem Manajemen Transportasi Online** merupakan proyek basis data yang dirancang untuk mengelola berbagai data dan aktivitas dalam layanan transportasi online. Sistem ini dibuat untuk mempermudah pengelolaan data pengguna, pengemudi, penumpang, pesanan, tarif, pembayaran, ulasan, dan promosi secara terstruktur.

Project ini menerapkan konsep **Database Management System (DBMS)** dan perancangan basis data relasional, mulai dari proses normalisasi hingga implementasi tabel dan relasi antarentitas menggunakan SQL.

---

## 🎯 Tujuan

Project ini bertujuan untuk:

- Merancang basis data yang terstruktur untuk sistem transportasi online.
- Menerapkan konsep normalisasi database hingga **3NF**.
- Membuat hubungan antar tabel menggunakan **Primary Key** dan **Foreign Key**.
- Mengelola data transaksi transportasi secara terintegrasi.
- Menerapkan perintah SQL untuk membuat, mengelola, dan mengambil data dari database.

---

## 🗂️ Entitas / Tabel

| No. | Tabel | Keterangan |
|---|---|---|
| 1 | `Pengguna` | Menyimpan data pengguna sistem |
| 2 | `Pengemudi` | Menyimpan data pengemudi |
| 3 | `Penumpang` | Menyimpan data penumpang |
| 4 | `Pesanan` | Menyimpan data pemesanan transportasi |
| 5 | `Tarif` | Menyimpan informasi tarif perjalanan |
| 6 | `Pembayaran` | Menyimpan data transaksi pembayaran |
| 7 | `Ulasan` | Menyimpan rating dan ulasan |
| 8 | `Promosi` | Menyimpan informasi promo atau diskon |

---

## 🔗 Relasi Database

Sistem menggunakan hubungan antar tabel untuk menghubungkan data yang saling berkaitan. Relasi tersebut menggunakan **Primary Key (PK)** sebagai identitas unik dan **Foreign Key (FK)** sebagai penghubung antar tabel.

Gambaran umum hubungan dalam sistem:

```text
Pengguna
   │
   ├── Pengemudi
   │
   └── Penumpang
          │
          ▼
       Pesanan
       │  │  │
       │  │  ├── Tarif
       │  ├──── Pembayaran
       │  ├──── Ulasan
       │  └──── Promosi
```

---

## 🛠️ Teknologi yang Digunakan

- **MySQL**
- **SQL**
- **ERD (Entity Relationship Diagram)**
- **Database Normalization**
- **Microsoft Excel** untuk pengelolaan data awal

---

## 📚 Konsep yang Diterapkan

Project ini menerapkan beberapa konsep dalam basis data, antara lain:

- Entity Relationship Diagram (ERD)
- Normalisasi **UNF → 1NF → 2NF → 3NF**
- Primary Key
- Foreign Key
- Relasi antar tabel
- Constraint
- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Query SQL

---

## 📁 Struktur Repository

```text
Sistem-Manajemen-Transportasi-Online/
│
├── README.md
├── database/
│   ├── create_database.sql
│   ├── create_table.sql
│   ├── insert_data.sql
│   └── query.sql
│
├── erd/
│   └── ERD.png
│
└── dokumentasi/
    └── laporan.pdf
```

> Nama file dapat disesuaikan dengan file yang terdapat di repository.

---

## 🚀 Cara Menjalankan

1. Pastikan **MySQL** atau aplikasi seperti **MySQL Workbench** sudah terinstal.
2. Buat database baru dengan nama:

```sql
CREATE DATABASE sistem_manajemen_transportasi_online;
```

3. Pilih database tersebut:

```sql
USE sistem_manajemen_transportasi_online;
```

4. Jalankan file SQL sesuai urutan:
   - Membuat database
   - Membuat tabel
   - Memasukkan data
   - Menjalankan query

5. Database siap digunakan.

---

## 📖 Kesimpulan

Sistem Manajemen Transportasi Online dibuat sebagai implementasi perancangan dan pengelolaan basis data pada layanan transportasi online. Dengan adanya database yang terstruktur dan memiliki relasi antar tabel, data dapat disimpan, dikelola, dan diakses dengan lebih mudah serta konsisten.
