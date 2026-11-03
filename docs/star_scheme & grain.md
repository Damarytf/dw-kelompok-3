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
        INT date_key FK
        INT vendor_key FK
        INT product_key FK
        INT employee_key FK
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
        BOOLEAN active_flag
    }

    dim_product {
        INT product_key PK
        INT product_id "NK: ProductID"
        VARCHAR product_name
        VARCHAR product_number
        VARCHAR category_name
        VARCHAR subcategory_name
    }

    dim_employee {
        INT employee_key PK
        INT employee_id "NK: BusinessEntityID"
        VARCHAR employee_name
        VARCHAR job_title
    }

    dim_date {
        INT date_key PK
        DATE full_date
        INT year
        INT quarter
        INT month_number
        VARCHAR month_name
    }

    dim_date ||--|{ fact_purchasing : "Memiliki Tanggal Order"
    dim_vendor ||--|{ fact_purchasing : "Dipesan Dari"
    dim_product ||--|{ fact_purchasing : "Membeli Produk"
    dim_employee ||--|{ fact_purchasing : "Diproses Oleh"
```

## Keterangan

• **PK**: Primary Key (surrogate key)  
• **FK**: Foreign Key ke tabel dimensi  
• **NK**: Natural Key dari sistem sumber  
• **Measure**: kolom ukuran (nilai numerik) pada tabel fakta  
