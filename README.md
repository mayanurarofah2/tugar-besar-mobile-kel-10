# proyek

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



Aplikasi mobile Bakehouse App untuk menampilkan produk bakery (cake, pastry, roti, cookies) dengan fitur login, pencarian produk, keranjang, profil, dan dark mode.
Backend menggunakan JSON Server sebagai REST API sederhana.

1 Setup Project
-Clone Repository
 HTTPS
 https://github.com/mayanurarofah2/tugar-besar-mobile-kel-10.git

 ssh
 git@github.com:mayanurarofah2/tugar-besar-mobile-kel-10.git

 cd tugar-besar-mobile-kel-10

-Install Dependency Flutter
flutter pub get

2  Setup Backend (JSON Server)
-folder backend:
cd backend

-Install dependency:
npm install

-Jalankan JSON Server:

json-server --watch db.json --host 0.0.0.0 --port 3000

-endpoint:
http://localhost:3000/users
http://localhost:3000/products
http://localhost:3000/cart

api_service.dart:
static const String baseUrl = "http://192.168.0.18:3000";

3 Menjalankan Aplikasi
-HP
flutter run

-Chrome (Web)
flutter run -d chrome

-Build APK
flutter build apk --release

APK berada di:
build/app/outputs/flutter-apk/app-release.apk

4 Dependencies yang Digunakan
-flutter
Digunakan sebagai framework utama untuk membangun aplikasi mobile 

-provider (versi ^6.1.1)
Digunakan sebagai state management untuk mengelola data aplikasi,data user (login), daftar produk, keranjang, dan pengaturan tema.

-http (versi ^1.2.0)
Digunakan untuk melakukan komunikasi dengan backend melalui REST API, seperti mengambil data produk dan proses login/register.

-shared_preferences (versi ^2.2.2)
Digunakan untuk menyimpan data secara lokal di perangkat, status login user dan pengaturan dark mode.

-cupertino_icons (versi ^1.0.8)
Digunakan untuk menyediakan ikon bergaya iOS pada aplikasi.

maeya nur arofah
0895322153838