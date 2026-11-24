# Laporan Progres Pekan [13]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian
| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Pembuatan etl/t01_ekstrak.ktr & Salin tabel sumber ke staging (validasi jumlah baris). | Hijau | |
| Transformasi tiap dimensi (.ktr per dimensi, aturan NULL sesuai dokumen mapping). | Hijau |  |
|Desain & Implementasi SCD Tipe 2 (contoh dim_produk dari riwayat biaya dengan versi ganda). | Hijau |  |
|Transformasi fakta & Database lookup ke setiap dimensi dengan nilai default -1. | Hijau | |
|Pembuatan etl/job_utama.kjb (ekstrak, kosongkan, dimensi, fakta) & eksekusi via Kitchen dari terminal. | Hijau |  |
| Proses rekonsiliasi & analisis hasil query rekonsiliasi setelah job dijalankan dua kali berturut-turut. | Hijau | [|
|Penyusunan laporan Steering Review pekan 13, pengumpulan log Kitchen, dan hasil rekonsiliasi. | Kuning | |
| Laporan laporan/pekan-12.md siap | Hijau |  |

## 2. Kendala pengerjaan

| No. | Masalah Teknis | Solusi yang Dicoba |
| :---: | :--- | :--- |
| 1 | Penyesuaian struktur skrip DDL SQL untuk pembuatan tabel Data Warehouse (*Fact* & *Dimension*) serta penyusunan visualisasi *Star Schema* agar dapat diimpor ke Draw.io. | Memanfaatkan fitur *Advanced SQL Import* di Draw.io untuk menggenerasi skema relasi secara otomatis berdasarkan skrip DDL SQL. |
| 2 | Jumlah *size* data AdventureWorks yang melebihi batas minimal (*size* > 40 MB). | Mengubah ukuran minimal *size* dari 40 MB ke 1000 MB. |

## 3. Kendala tim

* Tidak ada kendala berarti dalam komunikasi maupun pembagian kerja tim; seluruh anggota berkoordinasi dengan baik sesuai peran masing-masing.

## 4. Keputusan yang butuh persetujuan sponsor

