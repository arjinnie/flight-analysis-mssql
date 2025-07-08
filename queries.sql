use flights



-- en fazla kalkış yapan havalimanları
-- kalkış yapılan havalimanlarını uçuş sayısına göre sıralar (tüm havalimanları)
SELECT 
    origin,
    COUNT(*) AS flight_count
FROM flights
GROUP BY origin
ORDER BY flight_count DESC;




-- en uzun 10 uçuş
-- en uzun uçuş sürelerine (air_time) sahip 10 uçuşu listeler
SELECT TOP 10
    carrier,
    name,
    origin,
    dest,
    air_time,
    distance
FROM flights
WHERE air_time IS NOT NULL
ORDER BY air_time DESC;



-- uçuş sayısı ve ortalama gecikme süresi (aylara göre)
-- her ay için uçuş sayısı ve ortalama kalkış gecikmesini hesaplar
SELECT 
    month,
    COUNT(*) AS flight_count,
    AVG(CAST(dep_delay AS FLOAT)) AS avg_departure_delay
FROM flights
WHERE dep_delay IS NOT NULL
GROUP BY month
ORDER BY month;



-- en çok geciken 5 havalimanı (ortalama varış gecikme süreleri)
-- ortalama varış gecikmesine göre en çok geciken 5 kalkış havalimanını listeler

SELECT TOP 5
    origin,
    AVG(CAST(arr_delay AS FLOAT)) AS avg_arrival_delay
FROM flights
WHERE arr_delay IS NOT NULL
GROUP BY origin
ORDER BY avg_arrival_delay DESC;



-- en çok uçuş yapan 5 havalimanı
-- en fazla uçuş gerçekleştiren 5 kalkış havalimanını listeler

SELECT TOP 5
    origin,
    COUNT(*) AS flight_count
FROM flights
GROUP BY origin
ORDER BY flight_count DESC;




-- kısa mesafeli gecikmeli uçuşlar
-- 500 milden kısa mesafeli ve 15 dakikadan fazla kalkış gecikmesi olan uçuşları listeler
SELECT 
    carrier,
    name,
    origin,
    dest,
    distance,
    dep_delay
FROM flights
WHERE distance < 500 
    AND dep_delay > 15
    AND dep_delay IS NOT NULL
ORDER BY dep_delay DESC;



-- günlük uçuş yoğunluğu (tarihe görre)
-- her gün için uçuş sayısını tarihe göre hesaplar
SELECT 
    CONVERT(DATE, time_hour) AS flight_date,
    COUNT(*) AS flight_count
FROM flights
GROUP BY CONVERT(DATE, time_hour)
ORDER BY flight_date;



select * from dbo.flights
go


-- ortalama kalkış gecikmesi (havayolu şirketine göre)
-- her havayolu şirketinin ortalama kalkış gecikmesini hesaplar ve en yüksek gecikmeye sahip 10 h.y. şirketini listeler


SELECT TOP 10
    carrier,
    name,
    AVG(CAST(dep_delay AS FLOAT)) AS avg_departure_delay
FROM flights
WHERE dep_delay IS NOT NULL
GROUP BY carrier, name
ORDER BY avg_departure_delay DESC;



-- en yoğun havalimanları (kalkış sayısına göre)
-- kalkış yapılan havalimanlarını uçuş sayısına göre sıralar
SELECT 
    origin,
    COUNT(*) AS flight_count
FROM flights
GROUP BY origin
ORDER BY flight_count DESC;


-- en uzun uçuş süreleri
-- en uzun uçuş sürelerine sahip uçuşları listeler


SELECT TOP 5
    carrier,
    name,
    origin,
    dest,
    air_time,
    distance
FROM flights
WHERE air_time IS NOT NULL
ORDER BY air_time DESC;



-- gecikme oranı kalkış ve varış)
-- Havayolu şirketlerinin 15 dakikadan fazla geciken uçuşlarının yüzdesini hesaplar


SELECT 
    carrier,
    name,
    COUNT(*) AS total_flights,
    SUM(CASE WHEN dep_delay > 15 OR arr_delay > 15 THEN 1 ELSE 0 END) AS delayed_flights,
    ROUND(100.0 * SUM(CASE WHEN dep_delay > 15 OR arr_delay > 15 THEN 1 ELSE 0 END) / COUNT(*), 2) AS delay_percentage
FROM flights
WHERE dep_delay IS NOT NULL AND arr_delay IS NOT NULL
GROUP BY carrier, name
ORDER BY delay_percentage DESC;


-- popüler rotalar
-- en sık uçulan rotaları (kalkış-varış çifti) listeler
SELECT TOP 10
    origin,
    dest,
    COUNT(*) AS flight_count
FROM flights
GROUP BY origin, dest
ORDER BY flight_count DESC;


-- günün saatlerine göre ortalama gecikme
-- günün saatlerine göre ortalama kalkış gecikmesini hesaplar
SELECT 
    hour,
    AVG(CAST(dep_delay AS FLOAT)) AS avg_departure_delay
FROM flights
WHERE dep_delay IS NOT NULL
GROUP BY hour
ORDER BY hour;

-- erken varış oranı
-- her havayolu şirketinin erken varış oranını hesaplar (varış gecikmesi negatif olan uçuşlar
SELECT 
    carrier,
    name,
    COUNT(*) AS total_flights,
    SUM(CASE WHEN arr_delay < 0 THEN 1 ELSE 0 END) AS early_arrivals,
    ROUND(100.0 * SUM(CASE WHEN arr_delay < 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS early_arrival_percentage
FROM flights
WHERE arr_delay IS NOT NULL
GROUP BY carrier, name
ORDER BY early_arrival_percentage DESC;


--uçuş mesafesi ve gecikme ilişkisi
--uçuş mesafesi kategorilerine göre ortalama varış gecikmesini hesaplar
SELECT 
    CASE 
        WHEN distance < 500 THEN 'Kısa Mesafe (<500 mil)'
        WHEN distance BETWEEN 500 AND 1500 THEN 'Orta Mesafe (500-1500 mil)'
        ELSE 'Uzun Mesafe (>1500 mil)'
    END AS distance_category,
    AVG(CAST(arr_delay AS FLOAT)) AS avg_arrival_delay
FROM flights
WHERE arr_delay IS NOT NULL
GROUP BY 
    CASE 
        WHEN distance < 500 THEN 'Kısa Mesafe (<500 mil)'
        WHEN distance BETWEEN 500 AND 1500 THEN 'Orta Mesafe (500-1500 mil)'
        ELSE 'Uzun Mesafe (>1500 mil)'
    END
ORDER BY avg_arrival_delay DESC;



-- aylık uçuş sayısı ve gecikme ortalaması
-- aylara göre uçuş sayısı ve ortalama kalkış gecikmesini hesaplar
SELECT 
    month,
    COUNT(*) AS flight_count,
    AVG(CAST(dep_delay AS FLOAT)) AS avg_departure_delay
FROM flights
WHERE dep_delay IS NOT NULL
GROUP BY month
ORDER BY month;



-- havayolu şirketlerinin uçuş mesafesi dağılımı
-- her havayolu şirketinin ortalama uçuş mesafesini ve uçuş sayısını listeler
SELECT 
    carrier,
    name,
    COUNT(*) AS flight_count,
    AVG(CAST(distance AS FLOAT)) AS avg_distance
FROM flights
GROUP BY carrier, name
ORDER BY avg_distance DESC;