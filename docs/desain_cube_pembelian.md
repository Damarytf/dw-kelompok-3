# Dokumen Desain Cube - Proses Pembelian (Purchasing)

### Berdasarkan Star Schema `fact_purchasing`

Berikut adalah rancangan desain cube multidimensi yang dipetakan langsung dari skema bintang tabel fakta pembelian beserta tabel-tabel dimensinya:

| Elemen | Desain Hierarki / Metrik | Tabel Asal & Foreign Key (FK) |
| :--- | :--- | :--- |
| **Nama cube** | Pembelian | `fact_purchasing` |
| **Dimensi Waktu (Pemesanan)** | Tahun (`year`) > Kuartal (`quarter`) > Bulan (`month_name`) > Tanggal (`full_date`) | `dim_date` (via `order_date_key`) |
| **Dimensi Waktu (Pengiriman)** | Tahun > Kuartal > Bulan > Tanggal *(Role-playing)* | `dim_date` (via `ship_date_key`) |
| **Dimensi Geografi** | Negara (`country_region_name`) > Provinsi (`state_province_name`) > Kota (`city`) | `dim_geography` (via `geography_key`) |
| **Dimensi Produk** | Kategori (`category_name`) > Subkategori (`subcategory_name`) > Produk (`product_name`) | `dim_product` (via `product_key`) |
| **Dimensi Vendor** | Peringkat Kredit (`credit_rating`) > Vendor (`vendor_name`) | `dim_vendor` (via `vendor_key`) |
| **Dimensi Karyawan** | Jabatan (`job_title`) > Karyawan (`employee_name`) | `dim_employee` (via `employee_key`) |
| **Dimensi Pengiriman** | Metode Pengiriman (`ship_method_name`) | `dim_ship_method` (via `ship_method_key`) |
| **Measure (Fakta)** | - Total Nilai Transaksi (`line_total`, sum)<br>- Total Dipesan (`order_qty`, sum)<br>- Total Diterima (`received_qty`, sum)<br>- Total Ditolak (`rejected_qty`, sum)<br>- Total Masuk Stok (`stocked_qty`, sum) | Kolom ukuran di `fact_purchasing` |
| **Calculated member** | Persentase Penolakan % = (Total Ditolak / Total Diterima) * 100 | Dihitung otomatis di dalam Cube |

---
