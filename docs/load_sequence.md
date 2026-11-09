# Dokumentasi Urutan Load Data (Execution & Load Sequence) Domain Purchasing

Dokumen ini mendeskripsikan urutan kronologis pemuatan data (load sequence) dari database sumber (OLTP) / staging area menuju Data Warehouse (Tabel Dimensi dan Tabel Fakta) untuk domain **Purchasing**.

---

## 1. Strategi Pemuatan Data

Pemuatan data ke Data Warehouse wajib dilakukan secara berurutan (*staged loading*) untuk menjaga integritas data dan mencegah kesalahan referensi *foreign key* (*orphan keys*) pada tabel fakta.

Proses pemuatan dibagi menjadi **3 Tahap Utama**:
1. **Tahap 1: Static Dimension Loading** (Pemuatan tabel dimensi independen/statis).
2. **Tahap 2: Core Dimension Loading** (Pemuatan tabel dimensi utama: Vendor, Product, Employee).
3. **Tahap 3: Fact Loading** (Pemuatan tabel fakta pembelian).

---

## 2. Urutan Pemuatan Tabel (Load Sequence)

### **Tahap 1: Static Dimension Loading**
- **Tabel Target:** `dim_tanggal`
- **Sumber Data:** SQL CTE Script Rekursif (`dim_tanggal_mysql.sql`)
- **Tipe Load:** *Pre-populated / Full Load*
- **Penjelasan:** Diisi paling pertama sebelum proses ETL dari OLTP berjalan. Berisi data tanggal dari tahun 2010 s.d. 2015 serta nilai *default* `tanggal_key = -1` untuk data tanggal yang tidak diketahui.
- **Ketergantungan:** Tidak ada (Harus pertama).

---

### **Tahap 2: Core Dimension Loading**

Pada tahap ini, dimensi utama diekstraksi dari database sumber `adventureworks2`, ditransformasikan, dan dimuat ke Data Warehouse untuk mengenerasi *Surrogate Key* (SK).

#### **1. Pemuatan `DimVendor`**
- **Sumber Data:** `Purchasing.Vendor`, `Person.BusinessEntityAddress`, `Person.Address`, `Person.StateProvince`
- **Tipe Load:** *Full Load / SCD Type 1*
- **Penjelasan:** Mengisi dimensi vendor/pemasok barang.
- **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

#### **2. Pemuatan `DimProduct`**
- **Sumber Data:** `Production.Product`, `Production.ProductSubcategory`, `Production.ProductCategory`
- **Tipe Load:** *Full Load / SCD Type 1*
- **Penjelasan:** Mengisi dimensi produk barang yang dibeli.
- **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

#### **3. Pemuatan `DimEmployee`**
- **Sumber Data:** `HumanResources.Employee`, `Person.Person`
- **Tipe Load:** *Full Load / SCD Type 1*
- **Penjelasan:** Mengisi dimensi staf/pegawai (*buyer*) yang melakukan pemesanan.
- **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

---

### **Tahap 3: Fact Loading**

Tabel fakta dimuat paling akhir setelah seluruh dimensi berhasil diisi dan diperbarui.

- **Tabel Target:** `FactPurchasing`
- **Sumber Data:** `Purchasing.PurchaseOrderHeader`, `Purchasing.PurchaseOrderDetail`
- **Tipe Load:** *Append / Incremental Load*
- **Proses Transformation & Lookup:**
  1. Melakukan *lookup* `VendorSK` dari `DimVendor` berdasarkan `VendorID` (`BusinessEntityID`).
  2. Melakukan *lookup* `ProductSK` dari `DimProduct` berdasarkan `ProductID`.
  3. Melakukan *lookup* `EmployeeSK` dari `DimEmployee` berdasarkan `EmployeeID` (`BusinessEntityID`).
  4. Melakukan *lookup* `OrderDateKey` dari `dim_tanggal` berdasarkan konversi format `OrderDate` (`YYYYMMDD`). Gunakan `-1` jika NULL.
  5. Melakukan *lookup* `ShipDateKey` dari `dim_tanggal` berdasarkan konversi format `ShipDate` (`YYYYMMDD`). Gunakan `-1` jika NULL.
  6. Ekstraksi metrik transaksi (`OrderQty`, `ReceivedQty`, `RejectedQty`, `UnitPrice`, `LineTotal`), serta kalkulasi proporsional untuk `TaxAmt` dan `Freight`.
- **Ketergantungan:** Membutuhkan `dim_tanggal`, `DimVendor`, `DimProduct`, dan `DimEmployee` selesai diproses.

---

## 3. Ringkasan Matriks Urutan Eksekusi Job Pentaho (Spoon)

| Urutan Eksekusi | Nama Transformation / Job | Tabel Target | Keterangan |
| :---: | :--- | :--- | :--- |
| **1** | `ktr_load_dim_tanggal.ktr` | `dim_tanggal` | Memastikan data dimensi tanggal siap sebelum ETL berjalan. |
| **2** | `ktr_load_dim_vendor.ktr` | `DimVendor` | Mengisi dimensi vendor/pemasok. |
| **3** | `ktr_load_dim_product.ktr` | `DimProduct` | Mengisi dimensi produk. |
| **4** | `ktr_load_dim_employee.ktr` | `DimEmployee` | Mengisi dimensi pegawai/buyer. |
| **5** | `ktr_load_fact_purchasing.ktr` | `FactPurchasing` | Dimuat paling akhir menggunakan lookup SK ke seluruh tabel dimensi domain purchasing. |
