-- Window Function
SELECT * FROM payments;
-- menghasilkan perhitungan berdasarkan keseluruhan(bukan tergantung pada kategorinya)
SELECT 
	customernumber,
	amount,
	ROUND(AVG(amount)OVER(),2 ) AS average_amount
FROM payments
ORDER BY customernumber;
