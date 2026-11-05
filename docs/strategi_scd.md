# Strategi Slowly Changing Dimension (SCD) - Skema Purchasing

Dokumen ini memuat penentuan strategi SCD untuk tiap tabel dimensi pada skema *Purchasing*, beserta tipe yang digunakan untuk kolom-kolom penting dan alasannya.

## 1. `dim_product` (Kombinasi SCD Type 1 & Type 2)
*   **SCD Type 2 (History Retained):** `standard_cost`, `list_price`, `subcategory_name`.
    *   *Alasan:* Ini adalah dimensi paling krusial untuk memakai Type 2. Perubahan harga (`standard_cost` dan `list_price`) wajib dilacak historinya. Jika vendor menaikkan harga material tahun ini, kita tidak boleh menimpa data harga tahun lalu agar perhitungan `line_total` dan metrik pengeluaran masa lalu tidak berubah dan tetap akurat.
*   **SCD Type 1 (Overwrite):** `product_name`, `color`, `size`, `weight`.
    *   *Alasan:* Jika ada koreksi ejaan nama barang atau pembaruan spesifikasi fisik, cukup timpa data lama. Hal ini tidak merusak metrik finansial riwayat pesanan.

## 2. `dim_vendor` (Kombinasi SCD Type 1 & Type 2)
*   **SCD Type 2:** `credit_rating`, `preferred_vendor_status`.
    *   *Alasan:* Status vendor memengaruhi keputusan bisnis. Jika sebuah vendor turun *credit rating*-nya atau dicabut status "preferred"-nya, kita butuh historinya untuk menganalisis apakah penurunan status ini berkorelasi dengan tingginya jumlah barang yang direjeksi (`rejected_qty`) pada periode waktu tersebut.
*   **SCD Type 1:** `vendor_name`, `account_number`, `purchasing_web_service_url`.
    *   *Alasan:* Pembaruan URL sistem vendor atau perubahan nama legal perusahaan murni bersifat perbaikan administratif.

## 3. `dim_employee` (Kombinasi SCD Type 1 & Type 2)
*   **SCD Type 2:** `job_title`.
    *   *Alasan:* Jika staf *purchasing* mendapat promosi jabatan, riwayat kinerjanya saat ia masih berada di posisi bawah harus dikaitkan dengan jabatannya saat itu, bukan ditimpa dengan jabatan barunya.
*   **SCD Type 1:** `employee_name`, `marital_status`, `vacation_hours`, `sick_leave_hours`.
    *   *Alasan:* Perubahan status pernikahan atau jatah sisa cuti adalah data SDM operasional yang tidak relevan dengan histori analisis performa pembelian. Selalu gunakan data paling mutakhir.

## 4. `dim_ship_method` (SCD Type 2)
*   **SCD Type 2:** `ship_base`, `ship_rate`.
    *   *Alasan:* Tarif dasar logistik dari perusahaan ekspedisi pasti berfluktuasi dari tahun ke tahun. Jika tarif baru menimpa tarif lama (Type 1), kalkulasi perbandingan biaya pengiriman historis akan rusak. Harus dibuat baris baru (Type 2) tiap ada perubahan tarif.

## 5. `dim_geography` (SCD Type 1)
*   **SCD Type 1:** `city`, `state_province_name`, `postal_code`.
    *   *Alasan:* Entitas wilayah sangat jarang berubah. Jika ada pemekaran provinsi atau pembetulan kode pos, dampaknya terhadap histori pengadaan barang sangat minim sehingga cukup di-*overwrite*.

## 6. `dim_date` (SCD Type 0)
*   **SCD Type 0 (Retain Original):** Semua atribut tanggal.
    *   *Alasan:* Tanggal bersifat statis. Atribut sebuah hari (misalnya tanggal 5 November 2026 adalah hari Kamis) selamanya akan sama. Tidak akan pernah ada perubahan data yang perlu dilacak.

---
**Catatan Implementasi:**
Karena `dim_product`, `dim_vendor`, `dim_employee`, dan `dim_ship_method` menerapkan **SCD Type 2**, maka desain tabel fisik untuk keempat tabel tersebut harus ditambahkan kolom *tracking* standar, yaitu:
1. `start_date` (Kapan versi data ini mulai berlaku)
2. `end_date` (Kapan versi data ini berakhir/kedaluwarsa)
3. `is_current_flag` (Penanda apakah ini baris data yang paling aktif saat ini)