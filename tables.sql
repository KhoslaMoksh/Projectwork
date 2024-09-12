-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 08, 2024 at 04:16 AM
-- Server version: 8.0.36
-- PHP Version: 8.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ariba`
--

-- --------------------------------------------------------

--
-- Table structure for table `CampaignResults`
--

CREATE TABLE `CampaignResults` (
  `campaign_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `impressions` int DEFAULT NULL,
  `clicks` int DEFAULT NULL,
  `conversions` int DEFAULT NULL,
  `total_revenue` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerActivity`
--

CREATE TABLE `CustomerActivity` (
  `customer_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_purchase_date` date DEFAULT NULL,
  `total_spent` decimal(10,2) DEFAULT NULL,
  `total_orders` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerFeedback`
--

CREATE TABLE `CustomerFeedback` (
  `feedback_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `customer_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `feedback_date` date NOT NULL,
  `rating` int NOT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CustomerPurchases`
--

CREATE TABLE `CustomerPurchases` (
  `customer_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `product_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `purchase_date` date NOT NULL,
  `quantity` decimal(5,1) DEFAULT NULL,
  `total_amount` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `customer_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `customer_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `registration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `MarketingCampaigns`
--

CREATE TABLE `MarketingCampaigns` (
  `campaign_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `campaign_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `budget` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ProductCategories`
--

CREATE TABLE `ProductCategories` (
  `category_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `parent_category_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ProductDemand`
--

CREATE TABLE `ProductDemand` (
  `product_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `demand` decimal(5,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ProductInventory`
--

CREATE TABLE `ProductInventory` (
  `product_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `store_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `stock` decimal(5,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ProductRevenue`
--

CREATE TABLE `ProductRevenue` (
  `product_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `revenue` decimal(7,2) NOT NULL,
  `profit_margin` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Products`
--

CREATE TABLE `Products` (
  `product_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `product_length` decimal(5,2) DEFAULT NULL,
  `product_depth` decimal(5,2) DEFAULT NULL,
  `product_width` decimal(5,2) DEFAULT NULL,
  `cluster_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hierarchy1_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hierarchy2_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hierarchy3_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hierarchy4_id` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hierarchy5_id` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SalesData`
--

CREATE TABLE `SalesData` (
  `product_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `store_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `sales` decimal(5,1) DEFAULT NULL,
  `revenue` decimal(7,2) DEFAULT NULL,
  `stock` decimal(5,1) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `promo_type_1` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promo_bin_1` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promo_type_2` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promo_bin_2` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `promo_discount_2` decimal(5,2) DEFAULT NULL,
  `promo_discount_type_2` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StoreLocations`
--

CREATE TABLE `StoreLocations` (
  `store_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Stores`
--

CREATE TABLE `Stores` (
  `store_id` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `storetype_id` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `store_size` int DEFAULT NULL,
  `city_id` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `StoreSales`
--

CREATE TABLE `StoreSales` (
  `store_id` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `date` date NOT NULL,
  `total_sales` decimal(10,2) DEFAULT NULL,
  `total_revenue` decimal(10,2) DEFAULT NULL,
  `total_profit` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CampaignResults`
--
ALTER TABLE `CampaignResults`
  ADD PRIMARY KEY (`campaign_id`,`date`);

--
-- Indexes for table `CustomerActivity`
--
ALTER TABLE `CustomerActivity`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `CustomerFeedback`
--
ALTER TABLE `CustomerFeedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `CustomerPurchases`
--
ALTER TABLE `CustomerPurchases`
  ADD PRIMARY KEY (`customer_id`,`product_id`,`purchase_date`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `MarketingCampaigns`
--
ALTER TABLE `MarketingCampaigns`
  ADD PRIMARY KEY (`campaign_id`);

--
-- Indexes for table `ProductCategories`
--
ALTER TABLE `ProductCategories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `ProductDemand`
--
ALTER TABLE `ProductDemand`
  ADD PRIMARY KEY (`product_id`,`date`);

--
-- Indexes for table `ProductInventory`
--
ALTER TABLE `ProductInventory`
  ADD PRIMARY KEY (`product_id`,`store_id`,`date`);

--
-- Indexes for table `ProductRevenue`
--
ALTER TABLE `ProductRevenue`
  ADD PRIMARY KEY (`product_id`,`date`);

--
-- Indexes for table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `SalesData`
--
ALTER TABLE `SalesData`
  ADD PRIMARY KEY (`product_id`,`store_id`,`date`);

--
-- Indexes for table `StoreLocations`
--
ALTER TABLE `StoreLocations`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `Stores`
--
ALTER TABLE `Stores`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `StoreSales`
--
ALTER TABLE `StoreSales`
  ADD PRIMARY KEY (`store_id`,`date`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
