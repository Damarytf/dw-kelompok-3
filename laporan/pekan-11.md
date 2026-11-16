# Laporan Progres Pekan [11]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian

| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Pemasangan dim_tanggal standar Versi 1.0 & penyimpanan hasil query pemeriksaan. | Hijau |[Link Menyusul] |
| Penulisan skrip sql/ddl.sql (seluruh dimensi & fakta, baris -1, foreign key, index, dan idempotent / aman dijalankan 2x). | Hijau |[Link Sql.ddl](https://github.com/Damarytf/dw-kelompok-3/blob/main/sql/ddl.sql), [dim tanggal mysql](https://github.com/Damarytf/dw-kelompok-3/blob/main/sql/dim_tanggal_mysql.sql) |
| Pengujian constraint (menjalankan 3 uji & menyimpan tangkapan layar pesan error). | Hijau | [Link Menyusul] |
| Pembuatan Kamus Data di docs/kamus-data.md (seluruh tabel DW, penjelasan dim_tanggal, dan versi skrip). | Hijau | [Link Menyusul] |
|Pembuatan ERD reverse engineering dari database (via DBeaver) dan perbandingan dengan Star Schema v2. | Hijau | [Link Menyusul] |
| Penambahan daftar tabel staging ke dalam dokumen mapping. | Hijau | [Link Mapping](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/mapping.md) |
| Wireframe dashboard, semua pertanyaan bisnis terwakili | Kuning | [Link Menyusul] |
| Penyusunan laporan progres menggunakan templat laporan serta penyertaan change request (jika ada). | Hijau | [Link Menyusul] |
| Laporan laporan/pekan-11.md siap | Hijau | [Laporan Pekan 11)](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-11.md) |

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
