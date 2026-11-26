# Laporan Progres Pekan [13]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian
| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Penyusunan olap/schema.xml sesuai desain cube pekan 10; memastikan tidak ada elemen merah di Schema Workbench. | Hijau | Menyusul |
| Konfigurasi Dimensi Waktu melalui DimensionUsage di tingkat Schema (bukan di dalam cube) & urutan bulan yang benar. | Hijau | Menyusul |
|Pembuatan minimal satu calculated member (misalnya margin persen atau harga rata-rata). | Hijau | Menyusul |
|Penulisan minimal 5 query MDX di olap/query.mdx, masing-masing diberi nomor pertanyaan bisnis yang dijawab. | Hijau | Menyusul |
|Pembuktian kesesuaian MDX dan SQL: tangkapan layar hasil MDX + SQL pembanding untuk tiap query, serta penjelasan selisih jika ada. | Hijau | Menyusul  |
| Proses rekonsiliasi & analisis hasil query rekonsiliasi setelah job dijalankan dua kali berturut-turut. | Hijau | Menyusul |
|Penyusunan laporan laporan/pekan-14.md untuk Steering Review pekan 14, termasuk pertanyaan bisnis yang belum bisa dijawab cube (jika ada). | Kuning | Menyusul |

## 2. Kendala pengerjaan

| No. | Masalah Teknis | Solusi yang Dicoba |
| :---: | :--- | :--- |
| 1 | Penyesuaian struktur skrip DDL SQL untuk pembuatan tabel Data Warehouse (*Fact* & *Dimension*) serta penyusunan visualisasi *Star Schema* agar dapat diimpor ke Draw.io. | Memanfaatkan fitur *Advanced SQL Import* di Draw.io untuk menggenerasi skema relasi secara otomatis berdasarkan skrip DDL SQL. |
| 2 | Jumlah *size* data AdventureWorks yang melebihi batas minimal (*size* > 40 MB). | Mengubah ukuran minimal *size* dari 40 MB ke 1000 MB. |

## 3. Kendala tim

* Tidak ada kendala berarti dalam komunikasi maupun pembagian kerja tim; seluruh anggota berkoordinasi dengan baik sesuai peran masing-masing.

## 4. Keputusan yang butuh persetujuan sponsor

