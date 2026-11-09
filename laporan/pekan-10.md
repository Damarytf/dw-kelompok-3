# Laporan Progres Pekan [10]

Kelompok      : 3

Proses bisnis : Pembelian

## 1.Star schema versi 2 sesuai catatan sponsor

[Gambar Star schema Ver 2](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme_v2.png)

## 2. Star schema memakai dim_tanggal standar, dim_produk mengikuti struktur standar
Penjelasan Star Schema :

Berdasarkan diagram star schema pada proses bisnis pembelian (fact_purchasing), tabel dim_date dan dim_product telah dirancang sesuai dengan standar data warehouse berdasarkan metodologi Kimball. Tabel dim_date memiliki atribut waktu yang lengkap, mulai dari hari, bulan, kuartal, dan tahun hingga penanda akhir pekan (is_weekend) serta tahun fiskal. Dimensi ini juga menerapkan konsep role-playing dimension dengan menghubungkan tiga kunci waktu pada tabel fact_purchasing, yaitu order_date_key, due_date_key, dan ship_date_key, sehingga analisis dapat dilakukan berdasarkan tahapan transaksi pembelian. Sementara itu, tabel dim_product mencakup informasi identitas produk, spesifikasi fisik, harga, stok minimum, serta hierarki kategori dan subkategori yang telah didenormalisasi. Selain itu, atribut start_date, end_date, dan is_current_flag menunjukkan bahwa dimensi produk telah mendukung penerapan metode Slowly Changing Dimension (SCD) untuk mencatat dan memantau perubahan informasi produk dari waktu ke waktu.

## 3. Mapping lengkap untuk semua kolom dimensi dan fakta

* Tidak ada kendala berarti dalam komunikasi maupun pembagian kerja tim; seluruh anggota berkoordinasi dengan baik sesuai peran masing-masing.

## 4. Strategi SCD tertulis, minimal satu dimensi tipe 2



## 5. Rencana pekan depan

| Target | Penanggung jawab |
|---|---|
| Eksekusi dan validasi skrip DDL Star Schema di database Data Warehouse | Arya Kusuma Negara |
| Menyusun skrip ETL (*Extract, Transform, Load*) untuk pengisian data *Fact* & *Dimension* | Muhammad Zuna |
| Finalisasi visualisasi diagram ERD Star Schema di Draw.io | Arya Kusuma Negara |
| Melengkapi matriks bus (*Bus Matrix*) dan daftar risiko awal | Seluruh Anggota Tim |

## 6. Kontribusi anggota

| Nama | Peran | Yang dikerjakan pekan ini | Bukti commit |
|---|---|---|---|
| Damar Randu Y.T.F | Project Manager | Menjaga target mingguan, menyusun laporan progres pekan 09, dan memimpin koordinasi tim. | [Laporan Pekan 9](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/project_charter.md) |
| Arya Kusuma Negara | Data Modeler | Merancang *Star Schema* v1, menyusun Kamus Data (*Data Dictionary*), dan membuat skrip DDL SQL (`FactPurchase` serta tabel dimensi). | [Star Schema](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme%20%26%20grain.md), [Bus Matrix](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/bus_matrix_pembelian.md), [Database Sumber](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Database%20Sumber.png) |
| Muhammad Zuna | ETL Developer | Melakukan penelusuran & profil data sumber pada skema `Purchasing` dan `Production` untuk alur ekstraksi. | [Database Sumber](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Database%20Sumber.png), [Data sumber profil](https://github.com/Damarytf/dw-kelompok-3/tree/main/etl/Sumber%20profil)  | 
| Ahmaed Wildan Razaqi | Dashboard Developer | Perancangan antarmuka dashboard | [Daftar Risiko Awal](https://github.com/Damarytf/dw-kelompok-
