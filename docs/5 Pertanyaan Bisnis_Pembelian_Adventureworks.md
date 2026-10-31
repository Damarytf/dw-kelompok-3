# Perencanaan Pertanyaan Bisnis - Proses Pembelian (Purchasing)

### Database: AdventureWorks

Berikut adalah tabel perencanaan 5 pertanyaan bisnis terukur beserta fakta dan dimensi terkait proses bisnis Pembelian:

|Pertanyaan bisnis|Fakta (ukuran)|Dimensi (sudut pandang)|
|-|-|-|
|Vendor mana yang memiliki total nilai pengeluaran pembelian (*total spend*) terbesar pada setiap tahunnya?|Nilai pengeluaran (`TotalDue` / `LineTotal`), Jumlah pesanan|Vendor, Tanggal (tahun)|
|Kategori atau jenis produk apa yang memiliki tingkat penolakan barang (*rejection rate*) tertinggi saat proses penerimaan?|Jumlah barang ditolak (`RejectedQty`), Jumlah barang diterima (`ReceivedQty`)|Produk (kategori/subkategori), Vendor, Tanggal (kuartal)|
|Metode pengiriman (*ship method*) mana yang menghasilkan rerata proporsi biaya pengiriman (*freight*) tertinggi dibanding total nilai pesanan?|Biaya pengiriman (`Freight`), Subtotal nilai pesanan (`SubTotal`)|Metode Pengiriman (`ShipMethod`), Tanggal (bulan/kuartal)|
|Karyawan (*purchasing agent*) mana yang memproses volume transaksi pengadaan barang terbanyak berdasarkan status pemesanan?|Jumlah unit dipesan (`OrderQty`), Total nilai transaksi (`LineTotal`), Jumlah dokumen PO|Karyawan (`Employee/Buyer`), Status Pemesanan (`PO Status`)|
|Vendor mana yang memiliki selisih paling besar antara jumlah barang yang dipesan dengan jumlah bersih barang yang berhasil masuk ke stok (*stocked quantity*)?|Kuantitas dipesan (`OrderQty`), Kuantitas masuk stok (`StockedQty`), Kuantitas ditolak (`RejectedQty`)|Vendor, Produk, Tanggal (bulan)|



