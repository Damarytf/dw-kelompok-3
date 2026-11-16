# Kamus Data (Data Dictionary) — Data Warehouse Purchasing

* **Domain Bisnis:** Purchasing (Pengadaan Barang)
* **Arsitektur Skema:** Star Schema v2
* **Versi Skrip `dim_tanggal`:** Versi 1.0 (`dim_tanggal_mysql.sql` — Standar Dosen)
* **Versi Skrip DDL Tim:** Versi 2.0 (`sql/ddl.sql`)

---

## 1. Penjelasan `dim_tanggal` (Dimensi Waktu)

Tabel `dim_tanggal` berfungsi sebagai dimensi kalender terpusat yang digunakan bersama oleh seluruh tim untuk menganalisis transaksi pembelian berdasarkan dimensi waktu (hari, bulan, kuartal, dan tahun). Pada domain *Purchasing*, tabel ini diterapkan sebagai *role-playing dimension* yang direlasikan ke tiga atribut tanggal berbeda di dalam tabel fakta, yaitu `order_date_key` (tanggal pesanan dibuat), `due_date_key` (batas waktu barang harus diterima), dan `ship_date_key` (tanggal aktual pengiriman barang).

Tabel ini menerapkan strategi **SCD Type 0 (Retain Original)** karena atribut tanggal pada kalender bersifat statis dan tidak akan pernah berubah. Selain rentang tanggal operasional, dimensi ini juga menggunakan baris penanda `-1` (*Unknown Member*) untuk menampung transaksi yang tanggalnya belum tersedia di sistem sumber (misalnya pesanan yang masih berstatus diproses sehingga belum memiliki tanggal kirim).

---

## 2. Tabel Dimensi

### 2.1 `dim_produk` (Strategi: SCD Type 1 & Type 2)
Menyimpan master produk pengadaan. Menggunakan **SCD Type 2** pada atribut harga/biaya dan subkategori agar perubahan biaya standar tidak mengubah histori nilai belanja masa lalu.

| Nama Kolom | Tipe Data | Constraint | Strategi SCD | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `produk_key` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik internal DW (`-1` untuk Unknown). |
| `product_id` | `INT` | Not Null, Index | Natural Key | `Production.Product.ProductID` | ID asli produk dari sistem sumber. |
| `product_name` | `VARCHAR(100)` | Not Null | Type 1 | `Production.Product.Name` | Nama produk. |
| `product_number` | `VARCHAR(50)` | Nullable | Type 1 | `Production.Product.ProductNumber` | Kode nomor seri/SKU produk. |
| `color` | `VARCHAR(15)` | Nullable | Type 1 | `Production.Product.Color` | Warna fisik produk. |
| `size` | `VARCHAR(10)` | Nullable | Type 1 | `Production.Product.Size` | Ukuran fisik produk. |
| `weight` | `DECIMAL(8,2)` | Nullable | Type 1 | `Production.Product.Weight` | Berat bersih produk. |
| `standard_cost` | `DECIMAL(19,4)` | Nullable | Type 2 | `Production.Product.StandardCost` | Biaya standar produk (dilacak historinya). |
| `list_price` | `DECIMAL(19,4)` | Nullable | Type 2 | `Production.Product.ListPrice` | Harga katalog standar produk (dilacak historinya). |
| `safety_stock_level` | `INT` | Nullable | Type 1 | `Production.Product.SafetyStockLevel` | Batas minimum stok aman gudang. |
| `category_name` | `VARCHAR(50)` | Nullable | Type 1 | `Production.ProductCategory.Name` | Nama kategori utama produk. |
| `subcategory_name` | `VARCHAR(50)` | Nullable | Type 2 | `Production.ProductSubcategory.Name` | Nama subkategori produk (dilacak historinya). |
| `start_date` | `DATE` | Not Null | Metadata SCD2 | *System ETL Date* | Tanggal mulai berlakunya versi baris data. |
| `end_date` | `DATE` | Nullable | Metadata SCD2 | *System ETL Date* | Tanggal berakhirnya versi baris (`NULL` = aktif). |
| `is_current_flag` | `BOOLEAN` | Not Null | Metadata SCD2 | *System ETL Flag* | Status baris aktif (`TRUE` = aktif, `FALSE` = historis). |

### 2.2 `dim_vendor` (Strategi: SCD Type 1 & Type 2)
Menyimpan data pemasok barang. Menggunakan **SCD Type 2** pada peringkat kredit dan status vendor prioritas untuk menganalisis korelasi kualitas pemasok terhadap barang retur (`rejected_qty`).

| Nama Kolom | Tipe Data | Constraint | Strategi SCD | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `vendor_key` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik internal DW (`-1` untuk Unknown). |
| `vendor_id` | `INT` | Not Null, Index | Natural Key | `Purchasing.Vendor.BusinessEntityID` | ID asli pemasok dari sistem sumber. |
| `vendor_name` | `VARCHAR(100)` | Not Null | Type 1 | `Purchasing.Vendor.Name` | Nama perusahaan pemasok. |
| `account_number` | `VARCHAR(50)` | Nullable | Type 1 | `Purchasing.Vendor.AccountNumber` | Nomor akun pembukuan pemasok. |
| `credit_rating` | `INT` | Nullable | Type 2 | `Purchasing.Vendor.CreditRating` | Peringkat kelayakan kredit pemasok (skala 1–5). |
| `preferred_vendor_status` | `BOOLEAN` | Nullable | Type 2 | `Purchasing.Vendor.PreferredVendorStatus` | Status apakah pemasok merupakan vendor utama. |
| `active_flag` | `BOOLEAN` | Nullable | Type 1 | `Purchasing.Vendor.ActiveFlag` | Status keaktifan pemasok saat ini. |
| `purchasing_web_service_url` | `VARCHAR(255)` | Nullable | Type 1 | `Purchasing.Vendor.PurchasingWebServiceURL` | URL layanan pemesanan pemasok. |
| `start_date` | `DATE` | Not Null | Metadata SCD2 | *System ETL Date* | Tanggal mulai berlakunya versi data vendor. |
| `end_date` | `DATE` | Nullable | Metadata SCD2 | *System ETL Date* | Tanggal berakhirnya versi data vendor. |
| `is_current_flag` | `BOOLEAN` | Not Null | Metadata SCD2 | *System ETL Flag* | Status baris aktif (`TRUE` = aktif, `FALSE` = historis). |

### 2.3 `dim_employee` (Strategi: SCD Type 1 & Type 2)
Menyimpan data staf internal yang memproses *Purchase Order*. Menggunakan **SCD Type 2** pada `job_title` agar riwayat kinerja staf tetap tercatat sesuai jabatan saat transaksi dilakukan.

| Nama Kolom | Tipe Data | Constraint | Strategi SCD | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `employee_key` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik internal DW (`-1` untuk Unknown). |
| `employee_id` | `INT` | Not Null, Index | Natural Key | `HumanResources.Employee.BusinessEntityID` | ID asli karyawan dari sistem sumber. |
| `employee_name` | `VARCHAR(150)` | Not Null | Type 1 | `Person.Person` (First + Middle + Last Name) | Nama lengkap staf pemroses pesanan. |
| `national_id_number` | `VARCHAR(15)` | Nullable | Type 1 | `HumanResources.Employee.NationalIDNumber` | Nomor identitas karyawan. |
| `job_title` | `VARCHAR(50)` | Nullable | Type 2 | `HumanResources.Employee.JobTitle` | Jabatan karyawan (dilacak historinya). |
| `gender` | `VARCHAR(1)` | Nullable | Type 1 | `HumanResources.Employee.Gender` | Jenis kelamin (`M` / `F` / `U`). |
| `marital_status` | `VARCHAR(1)` | Nullable | Type 1 | `HumanResources.Employee.MaritalStatus` | Status pernikahan (`S` / `M` / `U`). |
| `hire_date` | `DATE` | Nullable | Type 1 | `HumanResources.Employee.HireDate` | Tanggal mulai bekerja. |
| `vacation_hours` | `INT` | Nullable | Type 1 | `HumanResources.Employee.VacationHours` | Sisa jam cuti tahunan. |
| `sick_leave_hours` | `INT` | Nullable | Type 1 | `HumanResources.Employee.SickLeaveHours` | Sisa jam izin sakit. |
| `start_date` | `DATE` | Not Null | Metadata SCD2 | *System ETL Date* | Tanggal mulai berlakunya versi data karyawan. |
| `end_date` | `DATE` | Nullable | Metadata SCD2 | *System ETL Date* | Tanggal berakhirnya versi data karyawan. |
| `is_current_flag` | `BOOLEAN` | Not Null | Metadata SCD2 | *System ETL Flag* | Status baris aktif (`TRUE` = aktif, `FALSE` = historis). |

### 2.4 `dim_ship_method` (Strategi: SCD Type 2)
Menyimpan metode ekspedisi pengiriman barang beserta riwayat tarif dasar dan tarif per unitnya.

| Nama Kolom | Tipe Data | Constraint | Strategi SCD | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `ship_method_key` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik internal DW (`-1` untuk Unknown). |
| `ship_method_id` | `INT` | Not Null, Index | Natural Key | `Purchasing.ShipMethod.ShipMethodID` | ID asli metode pengiriman. |
| `ship_method_name` | `VARCHAR(50)` | Not Null | Type 1 | `Purchasing.ShipMethod.Name` | Nama layanan ekspedisi pengiriman. |
| `ship_base` | `DECIMAL(19,4)` | Nullable | Type 2 | `Purchasing.ShipMethod.ShipBase` | Tarif dasar pengiriman per transaksi. |
| `ship_rate` | `DECIMAL(19,4)` | Nullable | Type 2 | `Purchasing.ShipMethod.ShipRate` | Tarif tambahan pengiriman per satuan berat/unit. |
| `start_date` | `DATE` | Not Null | Metadata SCD2 | *System ETL Date* | Tanggal mulai berlakunya tarif pengiriman. |
| `end_date` | `DATE` | Nullable | Metadata SCD2 | *System ETL Date* | Tanggal berakhirnya tarif pengiriman. |
| `is_current_flag` | `BOOLEAN` | Not Null | Metadata SCD2 | *System ETL Flag* | Status baris aktif (`TRUE` = aktif, `FALSE` = historis). |

### 2.5 `dim_geography` (Strategi: SCD Type 1)
Menyimpan hierarki wilayah alamat pemasok. Menggunakan **SCD Type 1** karena koreksi administratif wilayah tidak memerlukan pelacakan versi.

| Nama Kolom | Tipe Data | Constraint | Strategi SCD | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `geography_key` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik internal DW (`-1` untuk Unknown). |
| `address_id` | `INT` | Not Null, Index | Natural Key | `Person.Address.AddressID` | ID asli alamat dari sistem sumber. |
| `city` | `VARCHAR(50)` | Nullable | Type 1 | `Person.Address.City` | Nama kota lokasi pemasok. |
| `state_province_code` | `VARCHAR(3)` | Nullable | Type 1 | `Person.StateProvince.StateProvinceCode` | Kode provinsi/negara bagian. |
| `state_province_name` | `VARCHAR(50)` | Nullable | Type 1 | `Person.StateProvince.Name` | Nama lengkap provinsi/negara bagian. |
| `country_region_code` | `VARCHAR(3)` | Nullable | Type 1 | `Person.CountryRegion.CountryRegionCode` | Kode negara. |
| `country_region_name` | `VARCHAR(50)` | Nullable | Type 1 | `Person.CountryRegion.Name` | Nama lengkap negara. |
| `postal_code` | `VARCHAR(15)` | Nullable | Type 1 | `Person.Address.PostalCode` | Kode pos wilayah. |

---

## 3. Tabel Fakta

### 3.1 `fact_purchasing`
* **Grain:** Satu baris merepresentasikan satu rincian item produk dalam satu dokumen *Purchase Order*.

| Nama Kolom | Tipe Data | Constraint | Jenis | Sumber (OLTP AdventureWorks) | Deskripsi |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `purchase_fact_id` | `INT` | PK, Auto Increment | Surrogate Key | *Generated* | Kunci unik baris fakta. |
| `purchase_order_id` | `INT` | Not Null, Index | Natural Key | `Purchasing.PurchaseOrderHeader.PurchaseOrderID` | Nomor header *Purchase Order*. |
| `purchase_order_detail_id` | `INT` | Not Null, Index | Natural Key | `Purchasing.PurchaseOrderDetail.PurchaseOrderDetailID` | Nomor detail baris *Purchase Order*. |
| `order_date_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderHeader.OrderDate` -> `dim_tanggal` | Kunci tanggal pesanan dibuat. |
| `due_date_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderDetail.DueDate` -> `dim_tanggal` | Kunci batas waktu penerimaan barang. |
| `ship_date_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderHeader.ShipDate` -> `dim_tanggal` | Kunci tanggal barang dikirim (`-1` jika belum dikirim). |
| `vendor_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderHeader.VendorID` -> `dim_vendor` | Kunci dimensi pemasok. |
| `produk_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderDetail.ProductID` -> `dim_produk` | Kunci dimensi produk. |
| `employee_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderHeader.EmployeeID` -> `dim_employee` | Kunci dimensi staf pemroses pesanan. |
| `ship_method_key` | `INT` | Not Null, FK, Index | Foreign Key | `PurchaseOrderHeader.ShipMethodID` -> `dim_ship_method` | Kunci dimensi metode pengiriman. |
| `geography_key` | `INT` | Not Null, FK, Index | Foreign Key | `BusinessEntityAddress.AddressID` -> `dim_geography` | Kunci dimensi lokasi wilayah pemasok. |
| `order_qty` | `INT` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.OrderQty` | Jumlah unit barang yang dipesan. |
| `received_qty` | `INT` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.ReceivedQty` | Jumlah unit barang yang diterima dari pemasok. |
| `rejected_qty` | `INT` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.RejectedQty` | Jumlah unit barang yang ditolak/retur karena cacat. |
| `stocked_qty` | `INT` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.StockedQty` | Jumlah unit bersih yang masuk ke gudang. |
| `unit_price` | `DECIMAL(19,4)` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.UnitPrice` | Harga beli per unit saat transaksi terjadi. |
| `line_total` | `DECIMAL(19,4)` | Not Null | Measure | `Purchasing.PurchaseOrderDetail.LineTotal` | Total nilai pembelian pada baris detail. |