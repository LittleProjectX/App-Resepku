# Aplikasi Resep Masakan & Minuman 🍳🍹

Aplikasi *cross-platform* (Android & iOS) yang berfungsi untuk mencari, menyaring, dan menyimpan berbagai resep masakan serta minuman. Proyek ini dibangun menggunakan **Flutter** dan **Dart** dengan fokus pada performa yang optimal, arsitektur kode yang bersih, serta antarmuka pengguna yang responsif.

## 🚀 Fitur Utama

- **Pencarian & Filter Dinamis:** Pengguna dapat mencari resep berdasarkan nama atau menyaringnya berdasarkan kategori (makanan/minuman).
- **Detail Resep Lengkap:** Menampilkan bahan-bahan, langkah memasak, estimasi waktu, dan porsi secara detail.

## 🛠️ Tech Stack & Library

Aplikasi ini menggunakan ekosistem Flutter modern untuk memastikan kode mudah dirawat (*maintainable*) dan dikembangkan (*scalable*):

- **Framework:** Flutter (Dart)
- **State Management:** GetX
- **Networking:** Firebase Firestore / Realtime Database

## 📁 Struktur Folder (Arsitektur)

Proyek ini menerapkan arsitektur Clean Architecture untuk memisahkan logika bisnis dari UI:

```text
lib/
├── data/          # Model data, sumber data (API/Lokal), & repositori
├── domain/     # State management / Logika bisnis (jika pakai Provider/BLoC)
├── modeules/            # Lapisan antarmuka (Screens, Widgets, & Themes)
└── main.dart      # Titik masuk utama aplikasi
```

## 💻 Cara Menjalankan Proyek

Pastikan Anda sudah menginstal Flutter SDK di perangkat Anda.

1. Klon repositori ini:
   ```bash
   git clone https://github.com
   ```
2. Masuk ke direktori proyek:
   ```bash
   cd nama-repo
   ```
3. Unduh semua *dependencies / package*:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---
💡 *Proyek ini merupakan bagian dari portofolio profesional saya sebagai App Developer.*

---
## 👨‍💻 Author

- **Nanda Kharistian Gulo** - [LinkedIn](https://www.linkedin.com/in/nanda-kharistian-gulo-9b9327243?utm_source=share_via&utm_content=profile&utm_medium=member_android) - [Email Anda](kharistiann@gmail.com)

