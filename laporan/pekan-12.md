# Laporan Progres Pekan [12]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian
| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Pembuatan etl/t01_ekstrak.ktr & Salin tabel sumber ke staging (validasi jumlah baris). | Hijau |[t01_ekstrak v2](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/01-etl-t01-ekstrak-v2.png), [Mapping](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/mapping.md), [Database Sumber](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Database%20Sumber.png), [Konfigurasi dan Pengujian Preview Data pada Step Table Input (Extract Vendor)](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Gambar%201.%20Konfigurasi%20dan%20Pengujian%20Preview%20Data%20pada%20Step%20Table%20Input%20(Extract%20Vendor).jpeg), [Hasil Eksekusi (Run Execution Success)](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Gambar%202.%20Hasil%20Eksekusi%20(Run%20Execution%20Success)%20Transformation%20Extract%20Vendor%20Domain%20Purchasing.jpeg) |
| Transformasi tiap dimensi (.ktr per dimensi, aturan NULL sesuai dokumen mapping). | Hijau |[dim_karyawan](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/t02_dim_karyawan.ktr), [dim_Produk](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/t02_dim_produk.ktr), [dim_vendor](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/t02_dim_vendor.ktr), [dim_tanggal](https://github.com/Damarytf/dw-kelompok-3/blob/main/sql/dim_tanggal_mysql.sql), [cek_dim_tanggal](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/01_cek_dim_tanggal.png), [etl-t02-dim-vendor](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/02-etl-t02-dim-vendor.png), [etl-t02-dim-karyawan](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/03-etl-t02-dim-karyawan.png), [Pengecekan Null](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Pengecekan%20Null.jpeg), [etl-t02-dim-ship-method](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/11-etl-t02-dim-ship-method.png), [etl-t02-dim-geography](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/12-etl-t02-dim-geography.png),  |
|Desain & Implementasi SCD Tipe 2 (contoh dim_produk dari riwayat biaya dengan versi ganda). | Hijau | [t02_dim_produk](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/t02_dim_produk.ktr), [strategi_scd](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/strategi_scd.md), [etl-t02-dim-produk-scd2](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/04-etl-t02-dim-produk-scd2.png), [uji_error_check](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/04_uji_error_check.png) |
|Transformasi fakta & Database lookup ke setiap dimensi dengan nilai default -1. | Hijau | [t03_fact_purchasing](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/t03_fact_purchasing.ktr), [ddl.sql](https://github.com/Damarytf/dw-kelompok-3/blob/main/sql/ddl.sql), [etl-t03-fact-purchasing](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/05-etl-t03-fact-purchasing.png), [uji_error_pk](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/05_uji_error_pk.png), [uji_error_fk](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/03_uji_error_fk.png), [berapa pesanan yang tidak punya employee](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/berapa%20pesanan%20yang%20tidak%20punya%20employee.jpeg), [jumlah baris detail sebagai calon jumlah baris fakta](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/jumlah%20baris%20detail%20sebagai%20calon%20jumlah%20baris%20fakta.jpeg), [jumlah pesanan dan rentang tanggal](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/jumlah%20pesanan%20dan%20rentang%20tanggal.jpeg) |
|Pembuatan etl/job_utama.kjb (ekstrak, kosongkan, dimensi, fakta) & eksekusi via Kitchen dari terminal. | Hijau | [etl_jobutama](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/job_utama.kjb), [log_kitchen_job_utama](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/log_kitchen_job_utama.log), [load_sequence](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/load_sequence.md), [etl-job-utama-canvas](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/06-etl-job-utama-canvas.png), [etl-job-utama-sukses](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/07-etl-job-utama-sukses.png), [kitchen-cli-run-1](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/09-kitchen-cli-run-1.png), [kitchen-cli-run-2](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/10-kitchen-cli-run-2.jpg) |
| Proses rekonsiliasi & analisis hasil query rekonsiliasi setelah job dijalankan dua kali berturut-turut. | Hijau |  |
|Penyusunan laporan Steering Review pekan 13, pengumpulan log Kitchen, dan hasil rekonsiliasi. | Kuning | [log_kitchen](https://github.com/Damarytf/dw-kelompok-3/blob/main/etl/log_kitchen_job_utama.log) |
| Laporan laporan/pekan-12.md siap | Hijau | [Laporan Pekan 12)](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-12.md) |

## 2. Kendala pengerjaan

| No. | Masalah Teknis | Solusi yang Dicoba |
| :---: | :--- | :--- |
| 1 | Penyesuaian struktur skrip DDL SQL untuk pembuatan tabel Data Warehouse (*Fact* & *Dimension*) serta penyusunan visualisasi *Star Schema* agar dapat diimpor ke Draw.io. | Memanfaatkan fitur *Advanced SQL Import* di Draw.io untuk menggenerasi skema relasi secara otomatis berdasarkan skrip DDL SQL. |
| 2 | Jumlah *size* data AdventureWorks yang melebihi batas minimal (*size* > 40 MB). | Mengubah ukuran minimal *size* dari 40 MB ke 1000 MB. |

## 3. Kendala tim

* Tidak ada kendala berarti dalam komunikasi maupun pembagian kerja tim; seluruh anggota berkoordinasi dengan baik sesuai peran masing-masing.

## 4. Keputusan yang butuh persetujuan sponsor



## 5. Rencana pekan depan (Isi masih template)

| Target | Penanggung jawab |
|---|---|
| Pembuatan etl/t01_ekstrak.ktr & Salin tabel sumber ke staging (validasi jumlah baris). | Muhammad Zuna |
| Transformasi tiap dimensi (.ktr per dimensi, aturan NULL sesuai dokumen mapping | Muhammad Zuna |
| Desain & Implementasi SCD Tipe 2 (contoh dim_produk dari riwayat biaya dengan versi ganda) | Arya Kusuma Negara & Muhammad Zuna |
| Transformasi fakta & Database lookup ke setiap dimensi dengan nilai default -1 | Muhammad Zuna |
| Proses rekonsiliasi & analisis hasil query rekonsiliasi setelah job dijalankan dua kali berturut-turut. | Ibad |
| Menyusun Laporan Pekan 12 menggunakan templat laporan progres (termasuk permintaan perubahan jika ada) untuk *Steering Review* pekan 12 |Damar Randu Y.T.F. |

## 6. Kontribusi anggota

| Nama | Peran | Yang dikerjakan pekan ini | Bukti commit |
|---|---|---|---|
| Damar Randu Y.T.F | Project Manager | Bertanggung jawab atas koordinasi keseluruhan progres pekan 12, penyusunan laporan akhir, serta memimpin presentasi dalam Steering Review pekan 13 | [Laporan Pekan 12)](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-12.md)  |
| Arya Kusuma Negara | Data Modeler | Bertanggung jawab memastikan kesiapan desain skema, aturan NULL pada dokumen mapping, serta mendefinisikan logika bisnis dan struktur SCD Tipe 2 (terutama pada dim_produk untuk penelusuran versi historis biaya) | [Link Menyusul] |
| Muhammad Zuna | ETL Developer |Bertanggung jawab penuh atas implementasi teknis di Pentaho PDI (Kettle), mulai dari staging (t01_ekstrak.ktr), transformasi dimensi & fakta, database lookup (-1), pembuatan job utama (job_utama.kjb), hingga eksekusi skrip menggunakan Kitchen dari terminal | [Link Menyusul] |
| Muhammad Irsyadul Ibad | OLAP Developer | Bertanggung jawab melakukan pengujian analitik, merancang dan mengeksekusi skrip rekonsiliasi, serta memvalidasi konsistensi data setelah job dijalankan berulang kali | [Link Menyusul] |
| Ahmad Wildan Razaqi | Dashboard Developer | persiapan integrasi struktur data baru untuk kebutuhan visualisasi laporan/dashboard berikutnya, serta mendukung Project Manager dalam penyusunan laporan kesiapan data. | [Link Menyusul] |
