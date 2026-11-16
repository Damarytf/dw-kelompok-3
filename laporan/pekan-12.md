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
| Damar Randu Y.T.F | Project Manager | Bertanggung jawab atas koordinasi keseluruhan progres pekan 12, penyusunan laporan akhir, serta memimpin presentasi dalam Steering Review pekan 13 | [Laporan Pekan 12)](https://github.com/Damarytf/dw-kelompok-3/blob/main/laporan/pekan-12.md)  |
| Arya Kusuma Negara | Data Modeler | Bertanggung jawab memastikan kesiapan desain skema, aturan NULL pada dokumen mapping, serta mendefinisikan logika bisnis dan struktur SCD Tipe 2 (terutama pada dim_produk untuk penelusuran versi historis biaya) | [Link Menyusul] |
| Muhammad Zuna | ETL Developer |Bertanggung jawab penuh atas implementasi teknis di Pentaho PDI (Kettle), mulai dari staging (t01_ekstrak.ktr), transformasi dimensi & fakta, database lookup (-1), pembuatan job utama (job_utama.kjb), hingga eksekusi skrip menggunakan Kitchen dari terminal | [Link Menyusul] |
| Muhammad Irsyadul Ibad | OLAP Developer | Bertanggung jawab melakukan pengujian analitik, merancang dan mengeksekusi skrip rekonsiliasi, serta memvalidasi konsistensi data setelah job dijalankan berulang kali | [Link Menyusul] |
| Ahmad Wildan Razaqi | Dashboard Developer | persiapan integrasi struktur data baru untuk kebutuhan visualisasi laporan/dashboard berikutnya, serta mendukung Project Manager dalam penyusunan laporan kesiapan data. | [Link Menyusul] |
