# ERD Data Warehouse Purchasing

Diagram star schema untuk proses pembelian (purchasing), dengan `fact_purchasing` sebagai tabel fakta dan empat tabel dimensi.

## Grain

**Satu baris pada `fact_purchasing` merepresentasikan satu item produk (detail baris) dalam satu purchase order, yaitu satu kombinasi `purchase_order_id` dan `purchase_order_detail_id`.**

```mermaid
erDiagram
    fact_purchasing {
        INT purchase_fact_id PK
        INT purchase_order_id "NK: Header ID"
        INT purchase_order_detail_id "NK: Detail ID"
        INT order_date_key FK "Ke dim_tanggal"
        INT due_date_key FK "Ke dim_tanggal"
        INT ship_date_key FK "Ke dim_tanggal"
        INT vendor_key FK
        INT produk_key FK "Revisi penamaan"
        INT employee_key FK
        INT ship_method_key FK
        INT geography_key FK
        INT order_qty "Measure"
        INT received_qty "Measure"
        INT rejected_qty "Measure"
        INT stocked_qty "Measure"
        DECIMAL unit_price "Measure"
        DECIMAL line_total "Measure"
    }

    dim_tanggal {
        INT id_tanggal PK
        DATE tanggal
        INT hari
        VARCHAR nama_hari
        INT bulan
        VARCHAR nama_bulan
        INT kuartal
        INT tahun
        BOOLEAN is_weekend
    }

    dim_produk {
        INT produk_key PK
        INT product_id "NK"
        VARCHAR product_name
        VARCHAR product_number
        VARCHAR color
        VARCHAR size
        DECIMAL weight
        DECIMAL standard_cost
        DECIMAL list_price
        INT safety_stock_level
        VARCHAR category_name
        VARCHAR subcategory_name
        DATE start_date "SCD2"
        DATE end_date "SCD2"
        BOOLEAN is_current_flag "SCD2"
    }

    dim_vendor {
        INT vendor_key PK
        INT vendor_id "NK"
        VARCHAR vendor_name
        VARCHAR account_number
        INT credit_rating
        BOOLEAN preferred_vendor_status
        BOOLEAN active_flag
        DATE start_date "SCD2"
        DATE end_date "SCD2"
        BOOLEAN is_current_flag "SCD2"
    }

    dim_employee {
        INT employee_key PK
        INT employee_id "NK"
        VARCHAR employee_name
        VARCHAR job_title
        VARCHAR gender
        DATE hire_date
        DATE start_date "SCD2"
        DATE end_date "SCD2"
        BOOLEAN is_current_flag "SCD2"
    }

    dim_geography {
        INT geography_key PK
        INT address_id "NK"
        VARCHAR city
        VARCHAR state_province_name
        VARCHAR country_region_name
        VARCHAR postal_code
    }

    dim_ship_method {
        INT ship_method_key PK
        INT ship_method_id "NK"
        VARCHAR ship_method_name
        DECIMAL ship_base
        DECIMAL ship_rate
        DATE start_date "SCD2"
        DATE end_date "SCD2"
        BOOLEAN is_current_flag "SCD2"
    }

    fact_purchasing }|--|| dim_tanggal : "Order/Due/Ship Date"
    fact_purchasing }|--|| dim_vendor : "Dipesan Dari"
    fact_purchasing }|--|| dim_produk : "Membeli Produk"
    fact_purchasing }|--|| dim_employee : "Diproses Oleh"
    fact_purchasing }|--|| dim_ship_method : "Dikirim Melalui"
    fact_purchasing }|--|| dim_geography : "Lokasi Vendor"
```

## Keterangan

* **PK**: Primary Key (surrogate key)
* **FK**: Foreign Key ke tabel dimensi
* **NK**: Natural Key dari sistem sumber
* **Measure**: kolom ukuran (nilai numerik) pada tabel fakta
