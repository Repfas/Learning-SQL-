SELECT * FROM "Invoice";
SELECT * FROM "Genre";
-- 1. Determine which countries have the most number of invoices (top 10).
-- Order them by the number of invoices in descending order and if there are the same number of invoices, 
-- sort them by country name in ascending order. Show Country Name and total number of invoices.

SELECT 
	"BillingCountry",
	COUNT("InvoiceId") AS number_of_invoices
FROM 
	"Invoice"
GROUP BY 
	1
ORDER BY 
	COUNT("InvoiceId")	DESC,
	"BillingCountry" ASC
LIMIT 10;

-- 2. The top 10 genres by total sales in the database. 
-- The total sales are obtained by multiplying the quantity of items sold by their respective prices. 
-- Shows Genre Name and Total Sales

SELECT 
	"Genre"."Name" AS "Genre_Music",
	SUM("InvoiceLine"."Quantity" * "InvoiceLine"."UnitPrice") AS "Total_Sales"
FROM "Genre"
JOIN "Track" USING("GenreId")
JOIN "InvoiceLine" USING("TrackId")
GROUP BY 1
ORDER BY 2 DESC, 1 ASC
LIMIT 10;
-- 3. 3.	(10 point ) Who are the top 10 customers by their total spending?
-- Shows Customer Name (consist of first name and last name), Email, and Total Spending
SELECT 
	CONCAT("Customer"."FirstName",' ',"Customer"."LastName") AS "FullName",
	"Customer"."Email",
	SUM("Invoice"."Total") AS "TotalSpending"
FROM 
	"Customer"
JOIN "Invoice" USING("CustomerId")
GROUP BY 1,2 
ORDER BY 3 DESC 
LIMIT 10;
-- 4. In the results list of countries in number 1,
-- which city has the most number of invoices? Show Country Name, City Name and total number of invoices.
SELECT 
	"BillingCountry" AS "CountryName",
	"BillingCity" AS "CityName",
	COUNT("InvoiceId") AS "TotalNumberInvoices"
FROM "Invoice"
WHERE "BillingCountry" IN (
		SELECT 
			"BillingCountry"
		FROM 
			"Invoice"
		GROUP BY 
			1
		ORDER BY 
			COUNT("InvoiceId")	DESC,
			"BillingCountry" ASC
		LIMIT 10)
GROUP BY 1,2
ORDER BY COUNT("InvoiceId") DESC
;

-- 5. The product team is looking to add some tracks from new artists to the store and market them in the United Kingdom. 
-- Due to budget constraints for marketing, the product team needs to select 4 out of 6 songs to include in the store.
-- The product team assumes that they should choose songs with genres that are popular in the United Kingdom. 
-- Here are the tracks and their respective genres that will be added to the store:
-- ●	"Lalaland": R&B/Soul
-- ●	"Soul Sister": Pop
-- ●	"Good to See You": Rock
-- ●	"Nothing On You": Jazz
-- ●	"Get Ya Before Sunrise": Reggae
-- ●	"Before The Coffee Gets Cold": Hip Hop/Rap
-- Assist the product team in selecting the songs to be included in the store.
SELECT * FROM "Artist";
-- songs popularity in UK
SELECT
	"Genre"."Name",
	SUM("InvoiceLine"."Quantity") AS number_of_purchase
FROM "Genre"
JOIN "Track" USING("GenreId")
JOIN "InvoiceLine" USING("TrackId")
JOIN "Invoice" Using ("InvoiceId")
JOIN "Customer" USING("CustomerId")
WHERE "Customer"."Country" = 'United Kingdom'
GROUP BY 1
ORDER BY 2 DESC, 1 ASC;
-- Opsi2 
SELECT
	"Genre"."Name",
	SUM("InvoiceLine"."Quantity") AS number_of_purchase,
	"Invoice"."BillingCountry"
FROM "Genre"
JOIN "Track" USING("GenreId")
JOIN "InvoiceLine" USING("TrackId")
JOIN "Invoice" Using ("InvoiceId")
WHERE "Invoice"."BillingCountry" = 'United Kingdom'
GROUP BY 1,3
ORDER BY 2 DESC, 1 ASC;
-- 6. The Product Team wants to market albums that are popular in the USA to be marketed in other countries.
-- Help the product team by searching for the 10 most popular albums in the USA based on album units sold
SELECT
	"Album"."Title",
	SUM("InvoiceLine"."Quantity") AS number_of_purchase
FROM "Album"
JOIN "Track" USING("AlbumId")
JOIN "InvoiceLine" USING("TrackId")
JOIN "Invoice" Using ("InvoiceId")
WHERE "Invoice"."BillingCountry" = 'USA'
GROUP BY 1
ORDER BY 2 DESC, 1 ASC
LIMIT 10;
-- 8. Some genres have low sales, the product team wants to analyze which genres need to be boosted by carrying out additional promotion or other strategies. 
-- Because each country has different behavior, the product team started by analyzing sales in USA
-- ( The total sales are obtained by multiplying the quantity of items sold by their respective prices)

SELECT 
	"Genre"."Name" AS Genre_name,
	"InvoiceLine"."Quantity",
	SUM("InvoiceLine"."UnitPrice" * "InvoiceLine"."Quantity") AS Total_Sales,
	"Invoice"."BillingCountry" AS Country
FROM "Genre"
JOIN "Track" USING("GenreId")
JOIN "InvoiceLine" USING("TrackId")
JOIN "Invoice" USING("InvoiceId")
WHERE "Invoice"."BillingCountry" = 'USA'
GROUP BY 1,4,2
ORDER BY 3 ASC;
-- 9.) We want to advertise songs to the customer based on how much each customers spent per genre. 
-- Help Marketing Team to find Top genre for each customers with the most spent
-- *DICARI RANKING PERTAMA DARI SETIAP 
WITH CustomerGenreSpending AS 
	(SELECT 
	"Customer"."CustomerId",
	CONCAT("Customer"."FirstName", ' ', "Customer"."LastName") AS FullName,
	"Genre"."Name" AS Genre,
	SUM("InvoiceLine"."UnitPrice" * "InvoiceLine"."Quantity") AS Total_spending
FROM "Customer"
JOIN "Invoice" USING("CustomerId")
JOIN "InvoiceLine" USING("InvoiceId")
JOIN "Track" USING("TrackId")
JOIN "Genre" USING("GenreId")
GROUP BY 1,2,3
ORDER BY 1 ),
RankedGenres AS (
    SELECT
        "CustomerId",
        FullName,
        Genre,
        Total_spending,
        RANK() OVER (PARTITION BY "CustomerId" ORDER BY Total_spending DESC) AS GenreRank
    FROM CustomerGenreSpending)
SELECT
    "CustomerId",
    FullName,
    Genre AS TopGenre,
    Total_spending AS AmountSpent
FROM RankedGenres
WHERE GenreRank = 1
ORDER BY 1
;
-- 7. Provide a table that aggregates purchase data by country. 
-- In cases where a country has only one customer, group these countries as 'Other.' 
-- The results should be sorted by total sales in descending order.
-- Information to calculate:
-- ●	Total Number of Customers: Calculate the count of unique customers within each country.
-- ●	Total Value of Sales: Sum the total sales value for each country.
-- ●	Average Value of Sales per Customer: Divide the total sales value by the number of unique customers in each country
-- ●	Average Order Value: Divide the total sales value by the number of orders (invoices) placed in each country to calculate the average order value.

WITH CountrySales AS (
    SELECT 
        CASE 
            WHEN COUNT(DISTINCT c."CustomerId") = 1 THEN 'Other'
            ELSE c."Country"
        END AS Country,
        COUNT(DISTINCT c."CustomerId") AS TotalCustomers,
        SUM(i."Total") AS TotalSales,
        COUNT(DISTINCT i."InvoiceId") AS TotalOrders
    FROM "Customer" c
    JOIN "Invoice" i ON c."CustomerId" = i."CustomerId"
    GROUP BY c."Country"
)

SELECT 
    Country,
    SUM(TotalCustomers) AS "Total Number of Customers",
    ROUND(SUM(TotalSales), 2) AS "Total Value of Sales",
    ROUND(SUM(TotalSales) / SUM(TotalCustomers), 2) AS "Average Value of Sales per Customer",
    ROUND(SUM(TotalSales) / SUM(TotalOrders), 2) AS "Average Order Value"
FROM CountrySales
GROUP BY Country
ORDER BY 
    2 DESC;

--10.  The Marketing team wants to increase advertising in countries with customers who have spent the most money.
-- Help the Marketing team find the top 10 countries with the highest-spending customers.
SELECT
	"Invoice"."BillingCountry" AS Country,
	SUM("InvoiceLine"."UnitPrice" * "InvoiceLine"."Quantity") AS total_spend
FROM "Invoice"
JOIN "InvoiceLine"
	USING("InvoiceId") 
GROUP BY  1 
ORDER BY 2 DESC
LIMIT 10 
	
	
	
	

	
	
	
	