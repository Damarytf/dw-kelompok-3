# Dokumentasi Urutan Load Data (Execution & Load Sequence)

Dokumen ini mendeskripsikan urutan kronologis pemuatan data (load sequence) dari database sumber (OLTP) / staging area menuju Data Warehouse (Tabel Dimensi dan Tabel Fakta).

---

## 1. Strategi Pemuatan Data

Pemuatan data ke Data Warehouse wajib dilakukan secara berurutan (*staged loading*) untuk menjaga integritas data dan mencegah kesalahan referensi *foreign key* (*orphan keys*) pada tabel fakta.

Proses pemuatan dibagi menjadi **3 Tahap Utama**:
1. **Tahap 1: Static Dimension Loading** (Pemuatan tabel dimensi independen/statis).
2. **Tahap 2: Core Dimension Loading** (Pemuatan tabel dimensi utama).
3. **Tahap 3: Fact Loading** (Pemuatan tabel fakta).

---

## 2. Urutan Pemuatan Tabel (Load Sequence)

### **Tahap 1: Static Dimension Loading**
* **Tabel Target:** `dim_tanggal`
* **Sumber Data:** SQL CTE Script Rekursif (`dim_tanggal_mysql.sql`)
* **Tipe Load:** *Pre-populated / Full Load*
* **Penjelasan:** Diisi paling pertama sebelum proses ETL dari OLTP berjalan. Berisi data tanggal dari tahun 2010 s.d. 2015 serta nilai *default* `tanggal_key = -1` untuk data tanggal yang tidak diketahui.
* **Ketergantungan:** Tidak ada (Harus pertama).

---

### **Tahap 2: Core Dimension Loading**

Pada tahap ini, dimensi utama diekstraksi dari database sumber `adventureworks2`, ditransformasikan, dan dimuat ke Data Warehouse untuk mengenerasi *Surrogate Key* (SK).

#### **1. Pemuatan `DimCustomer`**
* **Sumber Data:** `Sales.Customer`, `Person.Person`, `Sales.Store`, `Person.PersonPhone`, `Person.EmailAddress`
* **Tipe Load:** *Full Load / SCD Type 1*
* **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

#### **2. Pemuatan `DimProduct`**
* **Sumber Data:** `Production.Product`, `Production.ProductSubcategory`, `Production.ProductCategory`
* **Tipe Load:** *Full Load / SCD Type 1*
* **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

#### **3. Pemuatan `DimTerritory`**
* **Sumber Data:** `Sales.SalesTerritory`
* **Tipe Load:** *Full Load*
* **Ketergantungan:** Tidak ada ketergantungan antar-dimensi lain.

---

### **Tahap 3: Fact Loading**

Tabel fakta dimuat paling akhir setelah seluruh dimensi berhasil diisi dan diperbarui.

* **Tabel Target:** `FactSales`
* **Sumber Data:** `Sales.SalesOrderHeader`, `Sales.SalesOrderDetail`
* **Tipe Load:** *Append / Incremental Load*
* **Proses Transformation & Lookup:**
  1. Melakukan *lookup* `CustomerSK` dari `DimCustomer` berdasarkan `CustomerID`.
  2. Melakukan *lookup* `ProductSK` dari `DimProduct` berdasarkan `ProductID`.
  3. Melakukan *lookup* `TerritorySK` dari `DimTerritory` berdasarkan `TerritoryID`.
  4. Melakukan *lookup* `tanggal_key` dari `dim_tanggal` berdasarkan konversi format `OrderDate` (`YYYYMMDD`). Gunakan `-1` jika NULL.
  5. Perhitungan metrik `LineTotal`, serta kalkulasi proporsional untuk `TaxAmt` dan `Freight`.
* **Ketergantungan:** Membutuhkan `dim_tanggal`, `DimCustomer`, `DimProduct`, dan `DimTerritory` selesai diproses.

---

## 3. Ringkasan Matriks Urutan Eksekusi Job Pentaho (Spoon)

| Urutan Eksekusi | Nama Transformation / Job | Tabel Target | Keterangan |
| :---: | :--- | :--- | :--- |
| **1** | `ktr_load_dim_tanggal.ktr` | `dim_tanggal` | Memastikan data dimensi tanggal siap sebelum ETL berjalan. |
| **2** | `ktr_load_dim_customer.ktr` | `DimCustomer` | Mengisi dimensi pelanggan. |
| **3** | `ktr_load_dim_product.ktr` | `DimProduct` | Mengisi dimensi produk. |
| **4** | `ktr_load_dim_territory.ktr` | `DimTerritory` | Mengisi dimensi wilayah. |
| **5** | `ktr_load_fact_sales.ktr` | `FactSales` | Dimuat paling akhir menggunakan lookup SK ke seluruh tabel dimensi. |
