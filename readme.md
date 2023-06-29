## ECoffe Database

Bu proje, ECoffe adında bir e-ticaret veritabanını oluşturmak için T-SQL sorgularını içermektedir. Veritabanı, kullanıcılar, ürünler, siparişler, adresler ve ödemeler gibi temel bileşenleri içermektedir. Ayrıca subquery, index, cursor, stored procedure, table-valued function ve constraintler gibi T-SQL öğelerini kullanarak daha gelişmiş sorgular ve veritabanı yönetimi işlemleri de gösterilmektedir.

### Veritabanı Yapısı

- Users: Kullanıcıların bilgilerini tutan tablo.
- Products: Ürünlerin bilgilerini tutan tablo.
- Orders: Siparişlerin bilgilerini tutan tablo.
- Addresses: Adreslerin bilgilerini tutan tablo.
- Payments: Ödemelerin bilgilerini tutan tablo.

### Örnek T-SQL Sorguları

- Subquery: Kullanıcıları ve belirli bir tutarı aşan siparişlerini getiren bir örnek sorgu.
- Index: Ürünler tablosunda UnitsInStock sütunu için bir index oluşturan bir örnek sorgu.
- Cursor: Users tablosundaki kullanıcıları döngüyle gezerek bilgilerini yazdıran bir örnek sorgu.
- Stored Procedure: Kullanıcıya göre siparişleri getiren bir saklı procedure örneği.
- Table-Valued Function: Belirli bir fiyat aralığındaki ürünleri getiren bir tablo değeri işlevi örneği.
- Constraintler: Kısıtlamaların (CHECK, DEFAULT, FOREIGN KEY) örneklerini içeren sorgular.


