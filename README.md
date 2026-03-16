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

2. Light Mode dan Dark Mode(Aplikasi menyediakan mode terang dan mode gelap yang dapat diganti melalui tombol pada halaman beranda).

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

