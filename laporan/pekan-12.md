# Laporan Progres Pekan [12]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian
| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Pembuatan etl/t01_ekstrak.ktr & Salin tabel sumber ke staging (validasi jumlah baris). | Hijau |[Link Menyusul] |
| Transformasi tiap dimensi (.ktr per dimensi, aturan NULL sesuai dokumen mapping). | Hijau |[Link Menyusul] |
|Desain & Implementasi SCD Tipe 2 (contoh dim_produk dari riwayat biaya dengan versi ganda). | Hijau | [Link Menyusul] |
|Transformasi fakta & Database lookup ke setiap dimensi dengan nilai default -1. | Hijau | [Link Menyusul] |
|Pembuatan etl/job_utama.kjb (ekstrak, kosongkan, dimensi, fakta) & eksekusi via Kitchen dari terminal. | Hijau | [Link Menyusul] |
| Proses rekonsiliasi & analisis hasil query rekonsiliasi setelah job dijalankan dua kali berturut-turut. | Hijau | [Link Menyusul] |
|Penyusunan laporan Steering Review pekan 13, pengumpulan log Kitchen, dan hasil rekonsiliasi. | Kuning | [Link Menyusul] |
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
| Damar Randu Y.T.F | Project Manager | Mengoordinasikan penyelesaian seluruh target pekan 11 serta menyusun laporan progres dan rekapitulasi change request | [Laporan Pekan 11)](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-11.md)  |
| Arya Kusuma Negara | Data Modeler | Menjadi motor utama dalam perancangan skrip DDL (sql/ddl.sql), dokumentasi kamus data, pembuatan ERD via reverse engineering, serta pembaruan dokumen mapping staging | [Link Menyusul] |
| Muhammad Zuna | ETL Developer | Bertanggung jawab mengeksekusi pemasangan dim_tanggal standar V1.0, memastikan skrip DDL dapat berjalan tanpa error saat diulang, serta melakukan uji constraint pada database | [Link Menyusul] |
| Muhammad Irsyadul Ibad | OLAP Developer | Berperan sebagai peninjau silang (peer review) terhadap kesesuaian struktur ERD, kamus data, dan kesiapan arsitektur tabel fakta-dimensi sebelum dilanjutkan ke tahap ETL penuh pada pekan berikutnya. | [Link Menyusul] |
| Ahmad Wildan Razaqi | Dashboard Developer | Membuat rancangan *wireframe* antarmuka dashboard, di mana setiap komponen visual diberi nomor referensi pertanyaan bisnis yang dijawabnya untuk memastikan seluruh pertanyaan bisnis terwakili dengan baik. | [Dasbboard beserta pertanyaan-pertanyaan refrensi](https://github.com/Damarytf/dw-kelompok-3/blob/main/dashboard/db.jpg) |
