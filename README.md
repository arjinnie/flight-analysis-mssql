# Havayolu Uçuş Verileri Analizi (MS SQL Server)

Bu proje 2013 yılına ait New York çıkışlı uçuş verilerini (`flights.csv`) Microsoft SQL Server kullanarak analiz eden SQL sorgularını içerir. Sorgular, havalimanı yoğunluğu, uçuş gecikmeleri, rota trendleri ve operasyonel performans metrikleri gibi analizler sunar. Projeyi veri analitiği ve SQL becerilerimi sergilemek amacıyla hazırladim.

## Proje Amacı
Bu proje, havayolu operasyonlarını anlamak ve iyileştirmek için veri analizi tekniklerini kullanır. Sorgular, aşağıdaki gibi analizler sağlar:
- Havalimanı yoğunluğu analizi
- Uçuş gecikme oranları ve nedenleri
- En sık uçulan rotalar ve uzun uçuşlar
- Günlük ve saatlik uçuş trendleri
- Mesafe bazlı gecikme ilişkileri vs.

Bu analizler, havayolu şirketlerinin operasyonel verimliliğini artırmak, gecikmeleri azaltmak, müşteri memnuniyetini iyileştirmek için kullanılabilir.


## Veri Seti / Data Set
- **Dosya**: `flights.csv`
- **Sütunlar**:
  - `id`: Uçuş kimliği
  - `year`, `month`, `day`: Uçuş tarihi
  - `dep_time`, `sched_dep_time`, `dep_delay`: Kalkış zamanı ve gecikmesi
  - `arr_time`, `sched_arr_time`, `arr_delay`: Varış zamanı ve gecikmesi
  - `carrier`, `name`: Havayolu şirketi kodu ve tam adı
  - `flight`, `tailnum`: Uçuş numarası ve uçak kuyruk numarası
  - `origin`, `dest`: Kalkış ve varış havalimanları
  - `air_time`, `distance`: Hava süresi ve uçuş mesafesi
  - `hour`, `minute`, `time_hour`: Kalkış saati ve tam zaman damgası
  - 
- **Kapsamı**: 2013 yılında New York havalimanlarından (EWR-JFK-LGA) kalkan uçuşlar
  


## Gereksinimler / Requierements

- Microsoft SQL Server (Express sürümü yeterli)
- SQL Server Management Studio (SSMS) veya Azure Data Studio
- Veri seti / Data Set: flights.csv


## Kullanım Adımları / Getting Started  

- Veri setini (flights.csv) indirmek için flights.zip dosyasını inidirip ayıklayın.
- SQL Server Management Studio (SSMS) üzerinde yeni bir veritabanı oluşturun:
  ```sql
  CREATE DATABASE flightsDB;
  ```
- Oluşturduğunuz veritabanına sağ tıklayın → "Tasks" → "Import Flat File".
- Kaynak olarak flights.csv dosyasını seçin.
- Hedef tablo adını flights olarak belirleyin ve sütunları eşleştirin.

- Verinin doğru yüklendiğini kontrol etmek için:
- 
   ```sql
  SELECT TOP 10 * FROM flights;
  
  ```
- queries.sql dosyasındaki sorguları SQL Server Management Studio (SSMS) ile çalıştırın.

  ## SQL Sorguları / SQL Queries
Aşağıdaki örnek sorgu, MS SQL Server için optimize edilmiştir ve tüm sorgular `queries.sql` dosyasında bulunmaktadır.


### 1. Ortalama Kalkış Gecikmesi
Havayolu şirketlerinin ortalama kalkış gecikmelerini hesaplar ve en yüksek gecikmeye sahip 10 şirketi listeler.

```sql
SELECT TOP 10
    carrier,
    name,
    AVG(CAST(dep_delay AS FLOAT)) AS avg_departure_delay
FROM flights
WHERE dep_delay IS NOT NULL
GROUP BY carrier, name
ORDER BY avg_departure_delay DESC;
```





## Lisans / License

This project is open source and available under the [MIT License](LICENSE).


## Katkılar / Contributing
Bu projeyi geliştirmek veya özelleştirmek isterseniz, lütfen bir pull request gönderin veya iletişime geçin.

## İletişim / Contact
Proje hakkında sorularınız varsa veya özelleştirme talebiniz varsa, bana şu adresten ulaşabilirsiniz:

GitHub: arjinnie





