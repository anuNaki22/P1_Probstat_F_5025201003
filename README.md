# Praktikum 1 Probstat F [Rahmat Faris Akbar / 5025201003]

## Daftar Isi
* [Daftar Isi](#daftar-isi)
* [Nomor 1](#nomor-1)
* [Nomor 2](#nomor-2)
* [Nomor 3](#nomor-3)
* [Nomor 4](#nomor-4)
* [Nomor 5](#nomor-5)
* [Nomor 6](#nomor-6)

## Nomor 1
Seorang penyurvei secara acak memilih orang-orang di jalan sampai dia bertemu dengan
seseorang yang menghadiri acara vaksinasi sebelumnya.

### **Soal 1a**
Berapa peluang penyurvei bertemu x = 3 orang yang tidak menghadiri acara vaksinasi
sebelum keberhasilan pertama ketika p = 0,20 dari populasi menghadiri acara vaksinasi ?
(distribusi Geometrik)

#### Penyelesaian
Pada soal, diketahui bahwa p = 0.20 dan x = 3. Diketahui juga bahwa soal ini meruapakan permasalahan distribusi geometrik. Sehingga pengimplementasian pada bahasa R bisa menggunakan command `dgeom` pada kondisi eksak.
```R
dgeom(x = 3, prob = .2)
```
Dari kode di atas, didapatkan hasil perhitungan 0.1024

<img width="99" alt="image" src="https://user-images.githubusercontent.com/99629909/162525950-8d90025d-66aa-4344-b6e9-3dc40d69c139.png">


### **Soal 1b**
mean Distribusi Geometrik dengan 10000 data random , prob = 0,20 dimana distribusi
geometrik acak tersebut X = 3 ( distribusi geometrik acak () == 3 )

#### Penyelesaian
Pada soal, diketahui bahwa digunakan 10000 data random dengan probabilitas keberhasilan dan X yang sama seperti soal sebelumnya. Untuk melakukan generate 10000 data random, digunakan command `rgeom` dengan parameter n = 10000 dan prob = 0.2. Karena pada soal ini digunakan banyak data, maka kita dapat menggunakan fungsi `mean` dengan kondisi X = 3.
```R
mean(rgeom(n=10000, prob=.2)==3)
```
Dari kode di atas, didapatkan hasil perhitungan kurang lebih 0.1024

<img width="288" alt="image" src="https://user-images.githubusercontent.com/99629909/162526548-e35f8d1e-b478-4916-b175-668503e4d33c.png">


### **Soal 1c**
Bandingkan Hasil poin a dan b , apa kesimpulan yang bisa didapatkan?

#### Penyelesaian
Dari perbandingan hasil poin a dan b dapat dilihat bahwa nilainya hampir sama antara keduanya. Sehingga dapat disimpulkan pada metode perhitungan eksak maupun simulasi (data random dengan `mean`) dapat diterapkan dalam menghitung persoalan peluang pada distribusi geometrik.


### **Soal 1d**
Histogram Distribusi Geometrik , Peluang X = 3 gagal Sebelum Sukses Pertama
Langkah-langkah untuk membuat grafik dalam distribusi geometrik adalah:
0. digunakan bantuan `library(dplyr)` dan `library(ggplot2)` untuk menampilkan grafik
1. melakukan permisalan atau menentukan range data randomnya. Pada kasus ini saya misalkan rangenya adalah antara 0 sampai 10
2. kemudian gunakan command `data.frame`. Pada command ini dibutuhkan parameter prob yang dapat dicari dengan menggunakan command `dgeom` dengan parameter sesuai ketentuan soal (prob = 0.2)
3. digunakan command `mutate` yang mengambil parameter dari banyak kesuksesan untuk dihighlight. Pada kasus ini adalah 3
4. kemudian tetapkan sumbu x sebagai keberhasilan (x) dan sumbu y sebagai prob/peluang distribusi binomial
5. atur posisi penempatan angka dan kata pada grafik, sehingga dapat terbaca dengan nyaman
6. digunakan command `labs` untuk memberikan nama pada grafik

Berikut ini merupakan kode untuk membuat grafik banyak kondisi sukses terhadap peluang distribusi binomial:
#### Penyelesaian
```R
library(dplyr)
library(ggplot2)

data.frame(x = 0:10, prob = dgeom(x = 0:10, prob = .2)) %>%
  mutate(Failures = ifelse(x == 3, 3, "other")) %>%
ggplot(aes(x = factor(x), y = prob, fill = Failures)) +
  geom_col() +
  geom_text(
    aes(label = round(prob,2), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 3,
    vjust = 0
  ) +
  labs(title = "Peluang X = 3 gagal Sebelum Sukses Pertama",
       subtitle = "Geometric(.2)",
       x = "Failures prior to first success (x)",
       y = "Probability")
```
Berikut ini merupakan tampilan grafiknya:

<img width="487" alt="image" src="https://user-images.githubusercontent.com/99629909/162556058-b7bc7b1b-4170-4a49-a621-3f51ed9db36b.png">

Sedangkan untuk menampilkan grafik histogram x (banyak kondisi sukses) terhadap frekuensi, dapat ditampilkan dengan langkah berikut ini:
1. generate data random menggunakan command `rgeom`. Disini saya mencontohkan dengan hanya mengambil 10000 data random
2. kemudian digunakan package library(tidyverse) untuk membantu dalam pembuatan grafik
3. digunakan command `qplot` dengan parameter geom adalah histogram dan set warna border sesuai yang kita inginkan

```R
x <- rgeom(10000, .2) 
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))
```
Berikut merupakan tampilan grafik histogram x (banyak kondisi sukses) terhadap frekuensi:

<img width="488" alt="image" src="https://user-images.githubusercontent.com/99629909/162556148-cf29f1ea-c6e5-452c-ba13-23fd0366a05e.png">

### **Soal 1e**
Nilai Rataan (μ) dan Varian (σ²) dari Distribusi Geometrik.

#### Penyelesaian
Nilai Rataan dengan kondisi eksak:
```R
p = 0.20
mean = 1/p
mean
```
Didapatkan nilai rataannya adalah 5

<img width="109" alt="image" src="https://user-images.githubusercontent.com/99629909/162553264-aea90806-0be8-43e9-98e8-819c55239bc1.png">


Nilai Rataan dengan kondisi simulated (data random):
```R
mean(rgeom(n = 10000, prob = .2)) + 1
```
Didapatkan nilai rataannya adalah kurang lebih 5 (dilakukan percobaan running beberapa kali)

<img width="329" alt="image" src="https://user-images.githubusercontent.com/99629909/162553308-f8f7f648-cc29-4674-87a1-2988f50d4883.png">


Nilai Varian dengan kondisi eksak:
```R
p = 0.20
var = (1 - p) / p^2
var
```
Didapatkan nilai variannya adalah 20

<img width="176" alt="image" src="https://user-images.githubusercontent.com/99629909/162553368-adb5887a-85b2-4b95-bd07-61267ea93b41.png">


Nilai Varian dengan kondisi simulated (data random):
```R
var(rgeom(n = 100000, prob = .2))
```
Didapatkan nilai variannya adalah kurang lebih 20 (dilakukan beberapa kali percobaan running)

<img width="290" alt="image" src="https://user-images.githubusercontent.com/99629909/162553409-19db09cb-b53d-4041-8315-2d0f30387f53.png">



## Nomor 2
Terdapat 20 pasien menderita Covid19 dengan peluang sembuh sebesar 0.2. Tentukan :

### **Soal 2a**
Peluang terdapat 4 pasien yang sembuh.

#### Penyelesaian
Dalam implementasi bahasa R, dapat digunakan fungsi `dbinom(x, size, prob)` untuk menghitung peluang dalam distribusi binomial. Pada soal diketahui bahwa terdapat 20 pasien menderita Covid19 yang digunakan sebagai parameter size, peluang sembuh 0.2 sebagai parameter probs, dan 4 pasien yang sembuh (sukses) sebagai parameter x.

```R
dbinom(x=4, size=20, prob=.2)
```
Dari kode di atas didapatkan hasil perhitungan peluang terdapat 4 pasien yang sembuh dari 20 pasien dengan peluang sembuh sebesar 0.2 adalah 0.2181994

<img width="256" alt="image" src="https://user-images.githubusercontent.com/99629909/162554237-e47fe2c4-7f96-4f7c-b527-6d8acc028abd.png">


### **Soal 2b**
Gambarkan grafik histogram berdasarkan kasus tersebut.

#### Penyelesaian
Langkah-langkah untuk membuat grafik dalam distribusi binomial adalah:
0. digunakan bantuan `library(dplyr)` dan `library(ggplot2)` untuk menampilkan grafik
1. melakukan permisalan atau menentukan range data randomnya. Pada kasus ini saya misalkan rangenya adalah antara 0 sampai 10
2. kemudian gunakan command `data.frame`. Pada command ini dibutuhkan parameter prob yang dapat dicari dengan menggunakan command `dbinom` dengan parameter sesuai ketentuan soal
3. digunakan command `mutate` yang mengambil parameter dari banyak kesuksesan untuk dihighlight. Pada kasus ini adalah 4
4. kemudian tetapkan sumbu x sebagai keberhasilan (x) dan sumbu y sebagai prob/peluang distribusi binomial
5. atur posisi penempatan angka dan kata pada grafik, sehingga dapat terbaca dengan nyaman
6. digunakan command `labs` untuk memberikan nama pada grafik

Berikut ini merupakan kode untuk membuat grafik banyak kondisi sukses terhadap peluang distribusi binomial:
```R
library(dplyr)
library(ggplot2)
#library(scales)

data.frame(heads = 0:10, prob = dbinom(x = 0:10, size = 20, prob = .2)) %>%
  mutate(Heads = ifelse(heads == 4, "4", "other")) %>%
  ggplot(aes(x = factor(heads), y = prob, fill = Heads)) +
  geom_col() +
  geom_text(
    aes(label = round(prob,4), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 2,
    vjust = 0
  ) +
  labs(title = "Probability of X = 4 successes.",
       subtitle = "b(20, .2)",
       x = "Successes (x)",
       y = "probability") 
```
Berikut ini merupakan tampilan grafiknya:

<img width="391" alt="image" src="https://user-images.githubusercontent.com/99629909/162554964-ce76e49a-7228-4b5c-b1ef-31a51d9af380.png">

Sedangkan untuk menampilkan grafik histogram x (banyak kondisi sukses) terhadap frekuensi, dapat ditampilkan dengan langkah berikut ini:
1. generate data random menggunakan command `rbinom`. Disini saya mencontohkan dengan hanya mengambil 10 data random
2. kemudian digunakan package library(tidyverse) untuk membantu dalam pembuatan grafik
3. digunakan command `qplot` dengan parameter geom adalah histogram dan set warna border sesuai yang kita inginkan

```R
x <- rbinom(10, 20, .2) 
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))
```
Berikut merupakan tampilan grafik histogram x (banyak kondisi sukses) terhadap frekuensi:

<img width="387" alt="image" src="https://user-images.githubusercontent.com/99629909/162555107-4271e787-84ff-4ae4-8c66-93f44ead89de.png">

### **Soal 2c**
Nilai Rataan (μ) dan Varian (σ²) dari Distribusi Binomial.

#### Penyelesaian
Rataan untuk kondisi eksak dapat dihitung dengan rumus
> mean(x) = size * p

Sehingga pengimplementasiannya dalam bahasa R adalah:
```R
n=20
p=0.2
mean = n * p
mean
```
Dari kode di atas didapatkan hasil rataan exact adalah 4

<img width="122" alt="image" src="https://user-images.githubusercontent.com/99629909/162555398-9a9dfdab-bd82-4515-b9a9-2f3af33d4146.png">

Rataan untuk kondisi simulasi (n data random) dapat dihitung dengan command `mean` dengan parameter `rbinom`. Misalkan n = 10, maka dapat dituliskan kode: 
```R
x <- rbinom(100, 20, .2) 
mean(x)
```
atau bisa juga dituliskan dengan format langsung sebagai berikut:
```R
mean(rbinom(n = 10, size = 20, prob = .2))
```
Dari kode di atas didapatkan hasil rataan simulasi adalah kurang lebih bernilai 4

<img width="361" alt="image" src="https://user-images.githubusercontent.com/99629909/162555554-55c7a3b2-f4fd-405b-ac08-b781944d546e.png">


Varian untuk kondisi eksak dapat dihitung dengan rumus
> var(x) = size * p * (1-p)

Sehingga pengimplementasiannya dalam bahasa R adalah:
```R
n=20
p=0.2
var = n * p * (1-p)
var
```
Dari kode di atas didapatkan hasil rataan exact adalah 3.2

<img width="178" alt="image" src="https://user-images.githubusercontent.com/99629909/162555687-0b6a6e93-f5a6-4536-a853-3b2bb220960e.png">

Varian untuk kondisi simulasi (n data random) dapat dihitung dengan command `var` dengan parameter `rbinom`. Misalkan n = 10, maka dapat dituliskan kode: 
```R
x <- rbinom(10, 20, .2) 
var(x)
```
atau bisa juga dituliskan dengan format langsung sebagai berikut:
```R
var(rbinom(n = 10, size = 20, prob = .2))
```
Dari kode di atas didapatkan hasil rataan simulasi adalah kurang lebih bernilai 3.2

<img width="355" alt="image" src="https://user-images.githubusercontent.com/99629909/162555760-939e0dca-5bf3-431e-89ed-f2cf9b31c251.png">



## Nomor 3
Diketahui data dari sebuah tempat bersalin di rumah sakit tertentu menunjukkan rata-rata historis
4,5 bayi lahir di rumah sakit ini setiap hari. (gunakan Distribusi Poisson)

### **Soal 3a**
Berapa peluang bahwa 6 bayi akan lahir di rumah sakit ini besok?

#### Penyelesaian
Pada soal diketahui bahwa rata-rata historis bayi lahir per hari atau lambdanya adalah 4,5. Sehingga dapat digunakan command `dpois` untuk menghitung peluang eksak (probability density function dari X), dimana nilai x adalah 6.

```R
dpois(x=6, lambda=4.5)
```
Didapatkan pluang bahwa 6 bayi akan lahir di rumah sakit ini besok adalah sebesar 0.1281201

<img width="198" alt="image" src="https://user-images.githubusercontent.com/99629909/162556341-114039d9-b420-4b51-872e-1e7f471d8227.png">

### **Soal 3b**
simulasikan dan buatlah histogram kelahiran 6 bayi akan lahir di rumah sakit ini selama setahun (n = 365)

#### Penyelesaian
Langkah-langkah untuk membuat grafik dalam distribusi poisson adalah:
0. digunakan bantuan `library(dplyr)` dan `library(ggplot2)` untuk menampilkan grafik
1. melakukan permisalan atau menentukan range data randomnya. Pada kasus ini saya misalkan rangenya adalah antara 0 sampai 10
2. kemudian gunakan command `data.frame`. Pada command ini dibutuhkan parameter prob yang dapat dicari dengan menggunakan command `dbinom` dengan parameter sesuai ketentuan soal
3. digunakan command `mutate` yang mengambil parameter dari banyak kesuksesan untuk dihighlight. Pada kasus ini adalah 4
4. kemudian tetapkan sumbu x sebagai keberhasilan (x) dan sumbu y sebagai prob/peluang distribusi binomial
5. atur posisi penempatan angka dan kata pada grafik, sehingga dapat terbaca dengan nyaman
6. digunakan command `labs` untuk memberikan nama pada grafik

Berikut ini merupakan kode untuk membuat grafik banyak kondisi sukses terhadap peluang distribusi binomial:
```R
library(dplyr)
library(ggplot2)
#library(scales)

data.frame(heads = 0:10, prob = dbinom(x = 0:10, size = 20, prob = .2)) %>%
  mutate(Heads = ifelse(heads == 4, "4", "other")) %>%
  ggplot(aes(x = factor(heads), y = prob, fill = Heads)) +
  geom_col() +
  geom_text(
    aes(label = round(prob,4), y = prob + 0.01),
    position = position_dodge(0.9),
    size = 2,
    vjust = 0
  ) +
  labs(title = "Probability of X = 4 successes.",
       subtitle = "b(20, .2)",
       x = "Successes (x)",
       y = "probability") 
```
Berikut ini merupakan tampilan grafiknya:

<img width="391" alt="image" src="https://user-images.githubusercontent.com/99629909/162554964-ce76e49a-7228-4b5c-b1ef-31a51d9af380.png">

Sedangkan untuk menampilkan grafik histogram x (banyak kondisi sukses) terhadap frekuensi, dapat ditampilkan dengan langkah berikut ini:
1. generate data random menggunakan command `rbinom`. Disini saya mencontohkan dengan hanya mengambil 10 data random
2. kemudian digunakan package library(tidyverse) untuk membantu dalam pembuatan grafik
3. digunakan command `qplot` dengan parameter geom adalah histogram dan set warna border sesuai yang kita inginkan

```R
x <- rbinom(10, 20, .2) 
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))
```
Berikut merupakan tampilan grafik histogram x (banyak kondisi sukses) terhadap frekuensi:

<img width="387" alt="image" src="https://user-images.githubusercontent.com/99629909/162555107-4271e787-84ff-4ae4-8c66-93f44ead89de.png">

```R
x <- rpois(365, 4.5) 
qplot(x, geom = "histogram", col = I("white"))
```

*screenshot*


### **Soal 3c**
dan bandingkan hasil poin a dan b , Apa kesimpulan yang bisa didapatkan

#### Penyelesaian


### **Soal 3d**
Nilai Rataan (μ) dan Varian (σ²) dari Distribusi Poisson.

#### Penyelesaian

Nilai rataan dapat dihitung dengan kode berikut:
```R
x <- rpois(365, 4.5) 
mean(x)
```
didapatkan rataannya adalah kurang lebih 4.5

<img width="186" alt="image" src="https://user-images.githubusercontent.com/99629909/162557244-54e6e0b6-01da-45c8-aa8a-8b8cb3fc3d6f.png">

Nilai varian dapat dihitung dengan kode berikut:
```R
x <- rpois(365, 4.5)  
var(x)
```
didapatkan rataannya adalah kurang lebih 4.5

<img width="185" alt="image" src="https://user-images.githubusercontent.com/99629909/162557286-cbf5302e-2a76-48a3-9ed4-7820f77c06f5.png">



## Nomor 4
Diketahui nilai x = 2 dan v = 10. Tentukan:

### **Soal 4a**
Fungsi Probabilitas dari Distribusi Chi-Square.

#### Penyelesaian
Pada soal diketahui bahwa nilai x adalah 2 dan nilai v atau derajat kebebasannya adalah 10

```R
pchisq(2, 10)
```
didapatkan hasilnya adalah 0.0037

<img width="127" alt="image" src="https://user-images.githubusercontent.com/99629909/162557411-b54e52e8-bd2b-452e-93d8-808e5cab6358.png">

### **Soal 4b**
Histogram dari Distribusi Chi-Square dengan 100 data random.

#### Penyelesaian
1. generate data random menggunakan command `rchisq`. Disini saya mencontohkan dengan hanya mengambil 100 data random sesuai ketentuan soal
2. pada `rchisq` membuthkan parameter berupa derajat kebebasan, dimana pada soal ini derajat kebebasannya bernilai 10
3. kemudian digunakan package library(tidyverse) untuk membantu dalam pembuatan grafik
4. digunakan command `qplot` dengan parameter geom adalah histogram dan set warna border sesuai yang kita inginkan
```R
x <- rchisq(100, 10)
library(tidyverse)
qplot(x, geom = "histogram", col = I("white"))
```

<img width="395" alt="image" src="https://user-images.githubusercontent.com/99629909/162557461-d8685031-82c5-402c-8492-a5a99aef554f.png">

### **Soal 4c**
Nilai Rataan (μ) dan Varian (σ²) dari Distribusi Chi-Square.

#### Penyelesaian
Nilai rataan dari distribusi Chi-Square adalah sama dengan derajat kebebasan. Atau bisa dituliskan dengan formula:
> μ = df

Sehingga nilai rataanya adalah 10.

Pengimplementasiannya dalam bahasa R adalah sebagai berikut:

```R
x <- rchisq(100, 10) 
mean(x)
```
Hasil running kode di atas mendapatkan nilai rataan yang sama sesuai dengan teori yaitu 10.

<img width="185" alt="image" src="https://user-images.githubusercontent.com/99629909/162557680-5f38e613-0372-47a7-b649-b057db10ecf8.png">

Nilai varian dari distribusi Chi-Square adalah sama dengan 2 kali derajat kebebasan. Atau bisa dituliskan dengan formula:
> μ = 2df

Sehingga nilai variannya adalah 20.

Pengimplementasiannya dalam bahasa R adalah sebagai berikut:

```R
x <- rchisq(100, 10)  
var(x)
```
Hasil running kode di atas mendapatkan nilai varian yang sama sesuai dengan teori yaitu 20.

<img width="182" alt="image" src="https://user-images.githubusercontent.com/99629909/162557729-5c2815bb-243d-4aa3-9e68-e629dc3e4229.png">



## Nomor 5
Diketahui bilangan acak (random variable) berdistribusi exponential (λ = 3). Tentukan

### **Soal 5a**
Fungsi Probabilitas dari Distribusi Exponensial

#### Penyelesaian


```R

```

*screenshot*


### **Soal 5b**
Histogram dari Distribusi Exponensial untuk 10, 100, 1000 dan 10000 bilangan random

#### Penyelesaian


```R

```

*screenshot*


### **Soal 5c**
Nilai Rataan (μ) dan Varian (σ²) dari Distribusi Exponensial untuk n = 100 dan λ = 3
Petunjuk:
- Gunakan set.seed(1)
- Gunakan fungsi bawaan R

#### Penyelesaian
Rataan untuk kondisi eksak dapat dihitung dengan rumus
> mean(x) = 1/lambda

Sehingga pengimplementasiannya dalam bahasa R adalah:
```R
lambda = 3
mean = 1/lambda
mean
```
Dari kode di atas didapatkan hasil rataan exact adalah 0.33

<img width="150" alt="image" src="https://user-images.githubusercontent.com/99629909/162558625-7fd8d526-c652-415b-9d33-cb138bc4d682.png">

Rataan untuk kondisi simulasi (n data random) dapat dihitung dengan command `mean` dengan parameter `rexp`. Misalkan n = 100, maka dapat dituliskan kode: 
```R
x <- rexp(100, 3) 
mean(x)
```
atau bisa juga dituliskan dengan format langsung sebagai berikut:
```R
mean(rexp(100,3))
```
Dari kode di atas didapatkan hasil rataan simulasi adalah kurang lebih bernilai 0.33

<img width="160" alt="image" src="https://user-images.githubusercontent.com/99629909/162558687-9992f381-a8c6-4a70-ad5b-4050fdb983a9.png">

Varian untuk kondisi eksak dapat dihitung dengan rumus
> var(x) = 1/(n * lambda^2)

Sehingga pengimplementasiannya dalam bahasa R adalah:
```R
n = 100
lambda = 3
var = 1/(lambda^2)
var
```
Dari kode di atas didapatkan hasil rataan exact adalah 0.11

<img width="174" alt="image" src="https://user-images.githubusercontent.com/99629909/162558947-69b6147e-a9cb-43c0-af98-98ebf6819044.png">

Varian untuk kondisi simulasi (n data random) dapat dihitung dengan command `var` dengan parameter `rexp`. Misalkan n = 100, maka dapat dituliskan kode: 
```R
x <- rexp(100, 3)  
var(x)
```
atau bisa juga dituliskan dengan format langsung sebagai berikut:
```R
var(rexp(100, 3))
```
Dari kode di atas didapatkan hasil rataan simulasi adalah bernilai sekitar 0.11

<img width="162" alt="image" src="https://user-images.githubusercontent.com/99629909/162558997-edac89a5-568d-4e4b-ab8b-644a875a53d5.png">



## Nomor 6
Diketahui generate random nilai sebanyak 100 data, mean = 50, sd = 8. Tentukan

### **Soal 6a**
Fungsi Probabilitas dari Distribusi Normal P(X1 ≤ x ≤ X2), hitung Z-Score Nya dan plot
data generate randomnya dalam bentuk grafik. Petunjuk(gunakan fungsi plot()).

Keterangan :

X1 = Dibawah rata-rata

X2 = Diatas rata-rata

Contoh data :

1,2,4,2,6,3,10,11,5,3,6,8

rata-rata = 5.083333

X1 = 5

X2 = 6

#### Penyelesaian


```R

```

*screenshot*


### **Soal 6b**
Generate Histogram dari Distribusi Normal dengan breaks 50 dan format penamaan:
**NRP_Nama_Probstat_{Nama Kelas}_DNhistogram**
Contoh :
312312312_Rola_Probstat_A_DNhistogram

#### Penyelesaian


```R

```

*screenshot*


### **Soal 6c**
Nilai Varian (σ²) dari hasil generate random nilai Distribusi Normal.

#### Penyelesaian


```R

```

*screenshot*









