Nama : Ahmad Samsul Arifin


Nim : 2409116113


Mini Project 2 Pemrograamn Aplikasi Bergerak



# Aplikasi Antrian Pelayanan di Kecamatan

## Deskripsi Aplikasi

Aplikasi ini dibuat menggunakan Flutter dan terintegrasi dengan database Supabase untuk membantu pengelolaan antrian pelayanan di kantor kecamatan.

Pelayan dapat melakukan login terlebih dahulu, kemudian dapat menambahkan, melihat, mengubah, dan menghapus data warga yang akan dilayani. Semua data yang dimasukkan akan langsung tersimpan di database Supabase, sehingga data tidak hanya tersimpan secara lokal.

Alasan saya membuat aplikasi dengan tema ini adalah karena pengalaman saya saat PKL di kantor kecamatan, dimana sistem antrian masih belum teratur dan masih dilakukan secara manual sehingga sering terjadi kebingungan dan ketidakteraturan antrian. Oleh karena itu saya mencoba membuat aplikasi ini untuk membantu meningkatkan kenyamanan pelayan maupun warga dalam proses pelayanan.

Data yang di gunakan dalam aplikasi layanan yaitu minimal 3 TextField, dan saya menggunakan 4 TextField  :
- Nama
- NIK
- Jenis Pelayanan
- Nomor HP

Semua data tersebut disimpan ke dalam database Supabase. Untuk nomor antrian dibuat otomatis dengan format 001, 002, 003, dan seterusnya, jadi semisal data antrian nomor 001 di hapus maka akan lanjut ke 002 dan tidak mengulang.

## Fitur Aplikasi

 ### Fitur Utama

1. Create(Fitur ini digunakan untuk menambahkan data antrian warga ke dalam database Supabase).
2. Read(Fitur ini digunakan untuk menampilkan daftar data antrian warga yang sudah tersimpan di database Supabase dalam bentuk list antrian).
3. Update(Fitur ini digunakan untuk mengubah atau memperbaiki data warga apabila terjadi kesalahan saat penginputan data).
4. Delete(Fitur ini digunakan untuk menghapus data antrian warga yang sudah selesai dilayani). Sebelum data dihapus akan muncul konfirmasi untuk memastikan apakah data benar-benar ingin dihapus.

### Nilai Tambah

1. Login dan Register(Aplikasi ini menggunakan Supabase Authentication sehingga pengguna harus login terlebih dahulu sebelum dapat mengakses aplikasi).

Fitur yang tersedia:
- Register akun baru
- Login akun
- Logout akun

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/624a9966-797f-4eb1-bf60-f771f98d39b3" />

2. Light Mode dan Dark Mode(Aplikasi menyediakan mode terang dan mode gelap yang dapat diganti melalui tombol pada halaman beranda).

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/110b4b00-095e-4ef1-9a76-e6fe30e3c1b1" />


<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/0fe0a00b-97ef-4437-98a1-ce06b98976da" />

3. Aplikasi ini menggunakan file .env untuk menyimpan informasi penting seperti:
- Supabase URL
- Supabase Anon API Key
Supabase URL dan API Key tidak disimpan langsung di dalam kode aplikasi. Sebagai gantinya, informasi tersebut disimpan di dalam file .env. Contoh isi .env: SUPABASE_URL=https://your-project-url.supabase.co, SUPABASE_KEY=your-anon-key. File .env dimasukkan ke dalam .gitignore agar tidak ikut ter-upload ke GitHub.

## Struktur Folder 

Folder yang saya gunakan terletak di lib dan satu file .env saya akan menyusunnya :

- lib
  - Models
      - data_antrian.dart
  - Pages
      - halaman_beranda.dart
      - halaman_detail_antrian.dart
      - halaman_form_antrian.dart
      - halaman_login.dart
      - halaman_register.dart
  - Services
      - antrian_service.dart
  - Main.dart
 
## Widget yang Digunakan

### Struktur Dasar
- MaterialApp
- Scaffold
- AppBar
- StatelessWidget
- StatefulWidget

### Layout dan Tampilan
- Column
- Row
- Container
- Card
- ListTile
- ListView.builder

### Form dan Input
  - TextField
  - TextFormField
  - DropdownButtonFormField

### Tombol dan Aksi
  - ElevatedButton
  - IconButton
  - FloatingActionButton

### Navigasi
  - Navigator

### Notifikasi dan Konfirmasi
  - SnackBar
  - AlertDialog

## Tampilan

### Halaman Login

Halaman ini digunakan untuk login ke dalam aplikasi menggunakan email dan password yang terdaftar di Supabase. Jika login berhasil, pelayan akan diarahkan ke halaman utama aplikasi. jika belum mempunyai akun atau belum terdaftar disupabase maka tampilan akan seperti ini, dan harus registrasi akun terlebih dahulu.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/28813c83-1977-4a01-8f7e-908cd55dc4b4" />

### Halaman Register 

Pada halaman ini digunakan untuk membuat akun baru. Pelayan dapat mendaftarkan akun dengan memasukkan Email dan Password serta konfirmasi password yang akan digunakan, akun yang dibuat akan disimpan di Supabase Authentication.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/8f55fec5-1472-4fd9-a5ed-65addd6665ad" />

Setelah melakukan register maka akan langsung balik masuk ke halaman login untuk melakukan login.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/7cb254b5-b374-4bba-80cf-0a2e978f13b8" />

apabila berhasil melakukan register maka otomatis akan terdaftar disupabase.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/3ec3993c-9d74-4650-9644-9731d8b72052" />

### Halaman Beranda 

Halaman utama aplikasi yang menampilkan daftar layanan yang sedang antrai. Fitur pada halaman ini antara lain:

tampilan halaman beranda itu saya sudah isi dengan data yang ada kalau saya hapus maka nomornya akan lanjut walaupun sudah tidak ada, contohnya itu no antrian 1 sudah tidak ada karena sudah saya hapus maka jika buat antrian lagi otmoatis lanjut ke nomor berikutnya.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/f1a75deb-463c-480a-8a6f-1f7e7e63f01a" />

Kemudian ada pencarian layanan bedasarkan nama,nik,pelayanan,dan no hp serta ada tombol refresh apabila kita sudah buat antrian tapi belum muncul.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/757967a7-e082-4d69-ac29-6f91689dd801" />

Kemudian ada juga untuk menambahkan data antiran baru.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/a101fd5e-d64e-40c2-8137-430251bc415a" />

Lanjut kemudian ada tombol dark mode dan light mode 

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/a246aaa3-78d5-4254-870c-0c8b8bc250b7" />


<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/f73c71ab-ab98-43b5-9a36-285388e3bb4e" />

Dan yang terakhir ada tombol logout yang otomatis langsung kembali ke halaman login.

### Halaman Tambah Antrian

Halaman yang digunakan untuk menambahkan data antrian baru ke dalam database. Data yang dimasukkan melalui halaman ini akan langsung tersimpan di Supabase.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/3dcd9a63-b26b-4281-8ee5-a54bd14128de" />

dan apabila data berhasil ditambahkan akan muncul dihalaman beranda.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/66efb382-0e19-4131-a058-cce61f12668e" />

### Halaman Detail Antrian

Halaman ini menampilkan informasi lengkap mengenai data antrian warga.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/761a09f5-49ff-483e-9132-a42169d1384a" />

Sedangkan ini adalah tampilan antrian yang ada di supabase.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/00c8f24a-001c-472c-b0f2-876d4d8893f1" />

### Halaman Hapus antrian

Halaman ini adalah ketika kita akan menghapus data antrian.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/799dd332-0690-4427-8427-387c26906b36" />

ini adalah tampilan halaman beranda setelah data berhasil dihapus data akan hilang.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/a4481e3f-4272-4d22-8d2a-4d89852d6507" />

dan ini tampilan di supabase setelah dihapus data antriannya.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/ca9a5386-dd51-4b26-b0bc-c413c4795e80" />

### Halaman Edit Antrian

Halaman ini digunakan untuk mengubah data yang sudah ada. Semua field yang tersedia dapat diperbarui sesuai kebutuhan. disini ada kesalahan pelayanan yang seharusnya pembuatan ktp malah salah pilih surat domisili.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/04a1a3b4-3923-4ab4-9c77-620a40d8cb72" />

Dan ini hasilnya jika berhasil.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/b8396123-8769-4a70-aff8-dd3d8ff3e22f" />

Dan ini tampilan terbaru di supabase.

<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/6b2478de-0392-4b4d-993d-44a5fc9c1470" />





