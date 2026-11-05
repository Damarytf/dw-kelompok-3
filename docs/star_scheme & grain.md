# ERD Data Warehouse Purchasing

Diagram star schema untuk proses pembelian (purchasing), dengan `fact_purchasing` sebagai tabel fakta dan empat tabel dimensi.

## Grain

**Satu baris pada `fact_purchasing` merepresentasikan satu item produk (detail baris) dalam satu purchase order, yaitu satu kombinasi `purchase_order_id` dan `purchase_order_detail_id`.**

```mermaid
erDiagram
    fact_purchasing {
        BIGINT purchase_fact_id PK
        INT purchase_order_id "NK: Header ID"
        INT purchase_order_detail_id "NK: Detail ID"
        INT order_date_key FK
        INT due_date_key FK
        INT ship_date_key FK
        INT vendor_key FK
        INT product_key FK
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

    dim_vendor {
        INT vendor_key PK
        INT vendor_id "NK: BusinessEntityID"
        VARCHAR vendor_name
        VARCHAR account_number
        INT credit_rating
        BOOLEAN preferred_vendor_status
        BOOLEAN active_flag
        VARCHAR purchasing_web_service_url
    }

    dim_product {
        INT product_key PK
        INT product_id "NK: ProductID"
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
    }

    dim_employee {
        INT employee_key PK
        INT employee_id "NK: BusinessEntityID"
        VARCHAR employee_name
        VARCHAR national_id_number
        VARCHAR job_title
        VARCHAR gender
        VARCHAR marital_status
        DATE hire_date
        INT vacation_hours
        INT sick_leave_hours
    }

    dim_geography {
        INT geography_key PK
        INT address_id "NK: AddressID"
        VARCHAR city
        VARCHAR state_province_code
        VARCHAR state_province_name
        VARCHAR country_region_code
        VARCHAR country_region_name
        VARCHAR postal_code
    }

    dim_ship_method {
        INT ship_method_key PK
        INT ship_method_id "NK: ShipMethodID"
        VARCHAR ship_method_name
        DECIMAL ship_base
        DECIMAL ship_rate
    }

    dim_date {
        INT date_key PK
        DATE full_date
        INT day_of_month
        VARCHAR day_name
        INT month_number
        VARCHAR month_name
        INT quarter
        INT year
        BOOLEAN is_weekend
        INT fiscal_year
    }

    fact_purchasing }|--|| dim_date : "Memiliki Tanggal (Order/Due/Ship)"
    fact_purchasing }|--|| dim_vendor : "Dipesan Dari (Who)"
    fact_purchasing }|--|| dim_product : "Membeli Produk (What)"
    fact_purchasing }|--|| dim_employee : "Diproses Oleh (Who)"
    fact_purchasing }|--|| dim_ship_method : "Dikirim Melalui (How)"
    fact_purchasing }|--|| dim_geography : "Lokasi Vendor (Where)"
```

## Keterangan

* **PK**: Primary Key (surrogate key)
* **FK**: Foreign Key ke tabel dimensi
* **NK**: Natural Key dari sistem sumber
* **Measure**: kolom ukuran (nilai numerik) pada tabel fakta
