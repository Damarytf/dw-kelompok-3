-- =====================================================================
-- Star Schema Data Warehouse Penjualan (MySQL / InnoDB)
-- Isi: 6 tabel dimensi + 1 tabel fakta (FactSales) beserta index
-- =====================================================================

-- Buat dan pilih database (ganti nama dw_sales jika ingin nama lain).
CREATE DATABASE IF NOT EXISTS dw_sales CHARACTER SET utf8mb4;
USE dw_sales;

SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- Hapus tabel lama (fakta dulu, baru dimensi)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS DimPromotion;
DROP TABLE IF EXISTS DimSalesPerson;
DROP TABLE IF EXISTS DimTerritory;
DROP TABLE IF EXISTS DimCustomer;
DROP TABLE IF EXISTS DimProduct;
DROP TABLE IF EXISTS DimDate;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- Tabel Dimensi
-- ---------------------------------------------------------------------
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    DayOfWeek TINYINT NOT NULL,
    DayName VARCHAR(10) NOT NULL,
    DayOfMonth TINYINT NOT NULL,
    Month TINYINT NOT NULL,
    MonthName VARCHAR(10) NOT NULL,
    Quarter TINYINT NOT NULL,
    Year INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DimProduct (
    ProductKey INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    Color VARCHAR(15),
    StandardCost DECIMAL(13,4),
    ListPrice DECIMAL(13,4),
    SubcategoryName VARCHAR(50),
    CategoryName VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DimCustomer (
    CustomerKey INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CustomerType VARCHAR(15) NOT NULL,
    CustomerName VARCHAR(150) NOT NULL,
    AccountNumber VARCHAR(15) NOT NULL,
    TerritoryID INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DimTerritory (
    TerritoryKey INT AUTO_INCREMENT PRIMARY KEY,
    TerritoryID INT NOT NULL,
    TerritoryName VARCHAR(50) NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    GroupRegion VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DimSalesPerson (
    SalesPersonKey INT AUTO_INCREMENT PRIMARY KEY,
    SalesPersonID INT NOT NULL,
    SalesPersonName VARCHAR(150) NOT NULL,
    JobTitle VARCHAR(50),
    CommissionPct DECIMAL(5,4),
    SalesQuota DECIMAL(13,4)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DimPromotion (
    PromotionKey INT AUTO_INCREMENT PRIMARY KEY,
    SpecialOfferID INT NOT NULL,
    PromotionName VARCHAR(255) NOT NULL,
    DiscountPct DECIMAL(5,4) NOT NULL,
    Type VARCHAR(50),
    Category VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Tabel Fakta
-- ---------------------------------------------------------------------
CREATE TABLE FactSales (
    SalesFactKey BIGINT AUTO_INCREMENT PRIMARY KEY,
    OrderDateKey INT NOT NULL,
    DueDateKey INT NOT NULL,
    ShipDateKey INT NOT NULL,
    ProductKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    TerritoryKey INT NOT NULL,
    SalesPersonKey INT NULL,
    PromotionKey INT NOT NULL,
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT NOT NULL,
    SalesOrderNumber VARCHAR(25) NOT NULL,
    OnlineOrderFlag TINYINT NOT NULL DEFAULT 0,
    OrderQty INT NOT NULL,
    UnitPrice DECIMAL(13,4) NOT NULL,
    UnitPriceDiscount DECIMAL(13,4) NOT NULL DEFAULT 0.0000,
    DiscountAmount DECIMAL(13,4) NOT NULL,
    ExtendedAmount DECIMAL(13,4) NOT NULL,
    LineTotal DECIMAL(13,4) NOT NULL,
    CONSTRAINT fk_fact_order_date FOREIGN KEY (OrderDateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT fk_fact_due_date FOREIGN KEY (DueDateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT fk_fact_ship_date FOREIGN KEY (ShipDateKey) REFERENCES DimDate(DateKey),
    CONSTRAINT fk_fact_product FOREIGN KEY (ProductKey) REFERENCES DimProduct(ProductKey),
    CONSTRAINT fk_fact_customer FOREIGN KEY (CustomerKey) REFERENCES DimCustomer(CustomerKey),
    CONSTRAINT fk_fact_territory FOREIGN KEY (TerritoryKey) REFERENCES DimTerritory(TerritoryKey),
    CONSTRAINT fk_fact_salesperson FOREIGN KEY (SalesPersonKey) REFERENCES DimSalesPerson(SalesPersonKey),
    CONSTRAINT fk_fact_promotion FOREIGN KEY (PromotionKey) REFERENCES DimPromotion(PromotionKey)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- Index untuk mempercepat query analitik
-- ---------------------------------------------------------------------
CREATE INDEX idx_fact_orderdate  ON FactSales(OrderDateKey);
CREATE INDEX idx_fact_product    ON FactSales(ProductKey);
CREATE INDEX idx_fact_customer   ON FactSales(CustomerKey);
CREATE INDEX idx_fact_territory  ON FactSales(TerritoryKey);
CREATE INDEX idx_fact_salesperson ON FactSales(SalesPersonKey);
CREATE INDEX idx_fact_promotion  ON FactSales(PromotionKey);
CREATE INDEX idx_fact_onlineflag ON FactSales(OnlineOrderFlag);
