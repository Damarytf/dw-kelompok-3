# Laporan Progres Pekan [10]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian

| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Star schema versi 2 sesuai catatan sponsor | Hijau |[Gambar Star schema Ver 2](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme_v2.png) |
| Star schema memakai dim_tanggal standar, dim_produk mengikuti struktur standar | Hijau |[images/Database Sumber](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Database%20Sumber.png) |
| Mapping lengkap untuk semua kolom dimensi dan fakta | Hijau | [Mapping](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/mapping.md) |
| Strategi SCD tertulis, minimal satu dimensi tipe 2 | Hijau | [Strategi SCD]([https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/5%20Pertanyaan%20Bisnis_Pembelian_Adventureworks.md](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/strategi_scd.md)) |
|Urutan load tertulis | Hijau | [Profil Data Sumber](https://github.com/Damarytf/dw-kelompok-3/tree/main/etl/Sumber%20profil), [Jumlah pesanan pembelian dan rentang tanggal transaksinya](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/jumlah%20pesanan%20dan%20rentang%20tanggal.jpeg), [Pengecekan Null](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Pengecekan%20Null.jpeg), [berapa pesanan yang tidak punya employee](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/berapa%20pesanan%20yang%20tidak%20punya%20employee.jpeg), [jumlah baris detail sebagai calon jumlah baris fakta](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/jumlah%20baris%20detail%20sebagai%20calon%20jumlah%20baris%20fakta.jpeg)|
| Tabel desain cube dengan minimal satu calculated member | Hijau | Skrip DDL SQL `FactPurchase` & tabel dimensi serta desain ERD Draw.io |
| Wireframe dashboard, semua pertanyaan bisnis terwakili | Kuning | [Bus Matrix](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/bus_matrix_pembelian.md) |
| Tangkapan layar Pentaho terhubung ke database sumber | Hijau | [Gambar 1.  Konfigurasi dan Pengujian Preview Data pada Step Table Input (Extract Vendor)](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Gambar%201.%20Konfigurasi%20dan%20Pengujian%20Preview%20Data%20pada%20Step%20Table%20Input%20(Extract%20Vendor).jpeg), [Gambar 2. Hasil Eksekusi (Run Execution Success) Transformation Extract Vendor Domain Purchasing)](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Gambar%202.%20Hasil%20Eksekusi%20(Run%20Execution%20Success)%20Transformation%20Extract%20Vendor%20Domain%20Purchasing.jpeg) |
| Laporan laporan/pekan-11.md siap | Hijau | - |

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
| Damar Randu Y.T.F | Project Manager | Mengoordinasikan seluruh progres anggota tim dan menyusun laporan akhir pekan menggunakan templat laporan progres yang telah ditentukan. | [Laporan Pekan 10](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-10.md) |
| Arya Kusuma Negara | Data Modeler | Menyesuaikan ulang rancangan *Star Schema* berdasarkan catatan evaluasi (*Steering Review*), menggunakan struktur `dim_tanggal` standar, dan menyesuaikan atribut `dim_produk` dengan standar yang ditetapkan.<br>Menentukan tipe *Slowly Changing Dimension* (SCD Tipe 1, 2, atau 3) untuk kolom-kolom penting pada tiap dimensi beserta alasannya, serta memastikan minimal satu dimensi menggunakan SCD Tipe 2. | [Star Schema Ver 2](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/star_scheme_v2.png), [Strategi SCD](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/strategi_scd.md)  |
| Muhammad Zuna | ETL Developer | Menyusun dokumentasi pemetaan (*Source-to-Target Mapping*) secara lengkap untuk setiap kolom di seluruh tabel dimensi dan tabel fakta menggunakan templat yang disediakan.<br>Menyusun daftar urutan pemuatan data (*load sequence*) secara kronologis dari tahap *staging* hingga tabel fakta.<br>Memasang Pentaho Data Integration, membuka aplikasi Spoon, membuat koneksi ke database sumber, menjalankan satu *Table Input* sederhana, dan mengambil tangkapan layar (*screenshot*) sebagai bukti. | [Mapping](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/mapping.md) |
| Muhammad Irsyadul Ibad | OLAP Developer | Merancang struktur *Cube* multidimensi yang mencakup pemetaan dimensi, hierarki, *measures*, serta minimal satu *calculated member*. | [Desain Cube](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/) |
| Ahmaed Wildan Razaqi | Dashboard Developer | Membuat rancangan *wireframe* antarmuka dashboard, di mana setiap komponen visual diberi nomor referensi pertanyaan bisnis yang dijawabnya untuk memastikan seluruh pertanyaan bisnis terwakili dengan baik. | [Wireframe Dashboard](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/) |


