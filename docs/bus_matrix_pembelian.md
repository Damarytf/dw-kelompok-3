# Baris Bus Matrix: Proses Pembelian (Purchasing)

Dokumen ini berisi representasi baris *Kimball Bus Matrix* untuk proses bisnis kelompok. Tabel di bawah memetakan dimensi apa saja yang terhubung dengan tabel fakta Pembelian, sekaligus menandai dimensi mana yang bersifat *conformed* sesuai dengan instruksi tugas Pekan 9.

| Proses Bisnis | `dim_date` **(C)** | `dim_product` **(C)** | `dim_employee` **(C)** | `dim_vendor` |
| :--- | :---: | :---: | :---: | :---: |
| **Pembelian (*Purchasing*)** | X | X | X | X |

---

### Keterangan Simbol

* **X** : Menandakan bahwa dimensi tersebut **dipakai** dan dihubungkan (*Foreign Key*) ke tabel fakta Pembelian.
* **(C)** : Menandakan bahwa dimensi tersebut bersifat ***Conformed***. Artinya, dimensi ini adalah dimensi standar yang direpresentasikan secara konsisten dan dapat digunakan bersama oleh proses bisnis / tabel fakta lain di dalam Data Warehouse AdventureWorks.

---

### Penjelasan Status Dimensi

1. **`dim_date` (Conformed)**
   Dimensi waktu mutlak bersifat *conformed* karena pasti digunakan oleh seluruh proses bisnis lain di AdventureWorks (seperti Penjualan, Produksi, dan Inventaris) untuk keperluan standarisasi analisis waktu.

2. **`dim_product` (Conformed)**
   Dimensi produk bersifat *conformed* karena entitas data produk saling beririsan dan digunakan lintas departemen (mulai dari data spesifikasi barang yang dibeli dari vendor, dipantau dalam inventaris, hingga akhirnya dijual ke pelanggan).

3. **`dim_employee` (Conformed)**
   Dimensi pegawai bersifat *conformed* karena tabel pekerja ini bisa digunakan dalam proses Pembelian (merepresentasikan staf pengadaan / *purchasing officer*) dan juga dalam proses Penjualan (merepresentasikan tenaga penjual / *sales person*).

4. **`dim_vendor` (Non-Conformed / Spesifik)**
   Sengaja tidak diberikan penanda (C) karena dimensi ini bersifat spesifik (terisolasi) hanya untuk domain bisnis Pembelian (*Purchasing*) atau Utang Usaha (*Accounts Payable*). Dimensi ini umumnya tidak dipakai bersama oleh proses operasional lain di luar urusan pengadaan barang.