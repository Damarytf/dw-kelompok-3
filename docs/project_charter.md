# Piagam Proyek (Project Charter) Data Warehouse Penjualan

## 1. Profil Proyek
Nama Proyek: Data Warehouse & Business Intelligence Penjualan (Sales) AdventureWorks
Proses Bisnis: Penjualan (Sales)
Project Sponsor: Mohamad Irwan Afandi, ST, M.Sc.
Repositori Git: `https://github.com/Damarytf/dw-kelompok-3.git`

## 2. Susunan Tim & Peran
| Nama Anggota | Peran Utama | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| Damar Randu Y.T.F | Project Manager | Menjaga target mingguan, menyusun laporan progres, memimpin Steering Review. |
| Arya Kusuma Negara | Data Modeler | Merancang star schema v1, menyusun kamus data, dan mengelola DDL SQL. |
| Muhammad Zuna | ETL Developer | Melakukan profil data sumber, merancang alur ekstraksi, dan membuat job Pentaho. |
| Muhammad Irsyadul Ibad | OLAP  | Merancang schema Mondrian MDX, wireframe |
| Ahmad Wildan Razaqi | Dashboard Developer | Merancang antarmuka web dashboard. |

## 3. Batasan Proyek (Scope)
 In-Scope: Seluruh transaksi penjualan *Online* dan *Reseller* (`sales.salesorderheader`, `sales.salesorderdetail`) beserta entitas pendukung (`customer`, `salesterritory`, `salesperson`, `specialoffer`, dan `product`).
 Out-of-Scope: Pembelian (*Purchasing*), Inventaris & Produksi (*Production Inventory*), serta Manajemen SDM (*Human Resources*).
