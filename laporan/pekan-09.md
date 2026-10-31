# Laporan Progres Pekan [09]

Kelompok      : 3

Proses bisnis : Pembelian

Status        : Hijau, Kuning, Merah

## 1. Target dan capaian

| Target pekan ini | Status | Bukti (tautan file, commit, tangkapan layar) |
|---|---|---|
| Bentuk tim dan tetapkan peran | Hijau | [Nama Anggota tim dan peran](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/project_charter.md) |
| Siapkan database sumber | Hijau |[images/Database Sumber](https://github.com/Damarytf/dw-kelompok-3/blob/main/Images/Database%20Sumber.png) |
| Pilih proses bisnis | Hijau | Proses bisnis Pembelian (*Purchasing*) |
| Tulis minimal 5 pertanyaan bisnis | Hijau | [Dokumen perencanaan 5 pertanyaan bisnis terukur](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/5%20Pertanyaan%20Bisnis_Pembelian_Adventureworks.md) |
| Profil data sumber | Hijau | [Profil Data Sumber Beserta bukti foto nya](https://github.com/Damarytf/dw-kelompok-3/tree/main/etl/Sumber%20profil) |
| Rancang star schema versi 1 | Hijau | Skrip DDL SQL `FactPurchase` & tabel dimensi serta desain ERD Draw.io |
| Isi baris bus matrix tim kalian | Kuning | [Bus Matrix](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/bus_matrix_pembelian.md) |
| Daftar risiko awal | Hijau | [Daftar Risiko Awal](https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/Daftar%20Risiko%20Awal%20dan%20Penanganan.md) |
| Tulis laporan pekan 09 | Hijau | Penyusunan laporan progres pekan 09 |

## 2. Kendala pengerjaan

Masalah teknis apa yang muncul? Apa yang sudah dicoba?

* **Masalah Teknis:** Penyesuaian struktur skrip DDL SQL untuk pembuatan tabel Data Warehouse (*Fact* & *Dimension*) serta penyusunan visualisasi *Star Schema* agar dapat diimpor ke Draw.io.
* **Solusi yang Dicoba:** Memanfaatkan fitur *Advanced SQL Import* di Draw.io untuk menggenerasi skema relasi secara otomatis berdasarkan skrip DDL SQL.

* **Masalah Teknis:** Jumlah Size Data Adventureworks yang melebihi minimal size (40mb)
* **Solusi yang Dicoba:** Mengubah Ukuran Minimal Size dari 40mb ke 1000mb

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
| Damar Randu Y.T.F | Project Manager | Menjaga target mingguan, menyusun laporan progres pekan 09, dan memimpin koordinasi tim. | https://github.com/Damarytf/dw-kelompok-3/blob/main/docs/project_charter.md |
| Arya Kusuma Negara | Data Modeler | Merancang *Star Schema* v1, menyusun Kamus Data (*Data Dictionary*), dan membuat skrip DDL SQL (`FactPurchase` serta tabel dimensi). | [Commit / Link Repository] |
| Muhammad Zuna | ETL Developer | Melakukan penelusuran & profil data sumber pada skema `Purchasing` dan `Production` untuk alur ekstraksi. | [Commit / Link Repository] |
| Muhammad Irsyadul Ibad | OLAP & Dashboard Developer | Menganalisis kebutuhan dimensi dan fakta untuk perancangan kueri OLAP dan antarmuka *dashboard*. | [Commit / Link Repository] |
