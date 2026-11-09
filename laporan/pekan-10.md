# Laporan Progres Pekan [10]

Kelompok      : 3

Proses bisnis : Pembelian

## 1.Star schema versi 2 sesuai catatan sponsor

[Gambar Star schema Ver 2]([https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme%20%26%20grain.md](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme_v2.png)),

## 2. Kendala pengerjaan

| No. | Masalah Teknis | Solusi yang Dicoba |
| :---: | :--- | :--- |
| 1 | Penyesuaian struktur skrip DDL SQL untuk pembuatan tabel Data Warehouse (*Fact* & *Dimension*) serta penyusunan visualisasi *Star Schema* agar dapat diimpor ke Draw.io. | Memanfaatkan fitur *Advanced SQL Import* di Draw.io untuk menggenerasi skema relasi secara otomatis berdasarkan skrip DDL SQL. |
| 2 | Jumlah *size* data AdventureWorks yang melebihi batas minimal (*size* > 40 MB). | Mengubah ukuran minimal *size* dari 40 MB ke 1000 MB. |

## 3. Kendala tim

* Tidak ada kendala berarti dalam komunikasi maupun pembagian kerja tim; seluruh anggota berkoordinasi dengan baik sesuai peran masing-masing.

## 4. Keputusan yang butuh persetujuan sponsor



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
