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

### Gambaran Schema XML (Mondrian)

Referensi kerangka skema XML untuk implementasi OLAP (Mondrian) menggunakan nama kolom dan tabel yang sesuai:

```xml
<Schema name="AdventureWorksDW">
  <Cube name="Pembelian">
    <Table name="fact_purchasing"/>
    
    <!-- Dimensi Waktu (berdasarkan Order Date) -->
    <Dimension name="Waktu Pemesanan" foreignKey="order_date_key" type="TimeDimension">
      <Hierarchy hasAll="true" primaryKey="date_key">
        <Table name="dim_date"/>
        <Level name="Tahun" column="year" type="Numeric" levelType="TimeYears"/>
        <Level name="Kuartal" column="quarter" type="Numeric" levelType="TimeQuarters"/>
        <Level name="Bulan" column="month_name" type="String" levelType="TimeMonths"/>
        <Level name="Tanggal" column="full_date" type="Date" levelType="TimeDays"/>
      </Hierarchy>
    </Dimension>

    <!-- Dimensi Geografi -->
    <Dimension name="Geografi" foreignKey="geography_key">
      <Hierarchy hasAll="true" primaryKey="geography_key">
        <Table name="dim_geography"/>
        <Level name="Negara" column="country_region_name" uniqueMembers="true"/>
        <Level name="Provinsi" column="state_province_name" uniqueMembers="false"/>
        <Level name="Kota" column="city" uniqueMembers="false"/>
      </Hierarchy>
    </Dimension>
    
    <!-- Dimensi Produk -->
    <Dimension name="Produk" foreignKey="product_key">
      <Hierarchy hasAll="true" primaryKey="product_key">
        <Table name="dim_product"/>
        <Level name="Kategori" column="category_name" uniqueMembers="false"/>
        <Level name="Subkategori" column="subcategory_name" uniqueMembers="false"/>
        <Level name="Nama Produk" column="product_name" uniqueMembers="true"/>
      </Hierarchy>
    </Dimension>

    <!-- Dimensi Vendor -->
    <Dimension name="Vendor" foreignKey="vendor_key">
      <Hierarchy hasAll="true" primaryKey="vendor_key">
        <Table name="dim_vendor"/>
        <Level name="Peringkat Kredit" column="credit_rating" uniqueMembers="false"/>
        <Level name="Nama Vendor" column="vendor_name" uniqueMembers="true"/>
      </Hierarchy>
    </Dimension>

    <!-- Dimensi Pegawai -->
    <Dimension name="Pegawai" foreignKey="employee_key">
      <Hierarchy hasAll="true" primaryKey="employee_key">
        <Table name="dim_employee"/>
        <Level name="Jabatan" column="job_title" uniqueMembers="false"/>
        <Level name="Nama Pegawai" column="employee_name" uniqueMembers="true"/>
      </Hierarchy>
    </Dimension>

    <!-- Measures -->
    <Measure name="Total Nilai Transaksi" column="line_total" aggregator="sum" formatString="#,##0.00"/>
    <Measure name="Kuantitas Dipesan" column="order_qty" aggregator="sum"/>
    <Measure name="Kuantitas Diterima" column="received_qty" aggregator="sum"/>
    <Measure name="Kuantitas Ditolak" column="rejected_qty" aggregator="sum"/>
    <Measure name="Kuantitas Masuk Stok" column="stocked_qty" aggregator="sum"/>

    <!-- Calculated Member -->
    <CalculatedMember name="Persentase Penolakan" dimension="Measures"
      formula="([Measures].[Kuantitas Ditolak] / [Measures].[Kuantitas Diterima]) * 100" formatString="#,##0.00'%'"/>
  </Cube>
</Schema>
```