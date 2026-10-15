# Week 4: H2 — Flutter Constraint Diagnosis & Fix Report

## Error 1: Bottom Overflow pada AlertDialog

### 🔴 Alasan Error
AlertDialog memberikan constraint tinggi maksimum terbatas pada area kontennya, tetapi Column di dalamnya tidak dapat me-resize atau me-scroll anak-anaknya secara vertikal ketika total tinggi gambar dan teks melebihi batas tinggi maksimum dialog.

### 📷 Screenshot Error
🔗 [Buka File Gambar Error 1](images/error/1.png)

### 💡 Solusi Perbaikan
Bungkus `Column` di dalam area konten `AlertDialog` menggunakan widget `SingleChildScrollView`. Dengan begitu, jika tinggi gambar dan teks melebihi area dialog, kontennya bisa di-scroll secara aman tanpa memicu error overflow.

### 📷 Screenshot Fixed
🔗 [Buka File Gambar Fixed 1](images/fixed/1.png)

---

## Error 2: Right Overflow pada Teks Panjang dalam Row

### 🔴 Alasan Error
Row memberikan constraint lebar tak terbatas (`maxWidth: double.infinity`) pada anak-anaknya, sehingga widget Text berukuran panjang mengembang melebihi batas lebar maksimum layar.

### 📷 Screenshot Error
🔗 [Buka File Gambar Error 2](images/error/2.png)

### 💡 Solusi Perbaikan
Bungkus widget `Text` menggunakan `Expanded` (atau `Flexible`) dan tambahkan properti `overflow: TextOverflow.ellipsis`. Cara ini memaksa `Text` membatasi lebarnya sesuai sisa ruang layar dan memotong teks panjang secara rapi dengan titik-titik (`...`).

### 📷 Screenshot Fixed
🔗 [Buka File Gambar Fixed 2](images/fixed/2.png)

---

## Error 3: Right Overflow pada Filter Chips dalam Row

### 🔴 Alasan Error
Tata letak Row tidak dapat melipat (*wrap*) atau me-scroll anak-anaknya secara horizontal ketika total gabungan lebar beberapa widget FilterChip melebihi batas lebar layar yang tersedia.

### 📷 Screenshot Error
🔗 [Buka File Gambar Error 3](images/error/3.png)

### 💡 Solusi Perbaikan
Bungkus chip dalam `ListView.separated` dengan `scrollDirection: Axis.horizontal` agar bisa di-scroll ke samping secara lancar, atau gunakan widget `Wrap` agar chip yang melebihi lebar layar otomatis turun ke baris bawahnya.

### 📷 Screenshot Fixed
🔗 [Buka File Gambar Fixed 3](images/fixed/3.png)
