## Widget that i extracted :

# 1. Characther Search Bar 

- Trigger                   = Reuse dan Readability.

- What it Owns              = Properti text pencairan yang akan di tampilkan dalam kolom input (query).

- What it Reports Upward    = Mengirimkan string hasil input ke RosterScreen setiap kali user menginput melalui callback onChanged (String value)

# 2. Element Filter Bar

- Trigger                   = Reuse dan Readability.

- What it Owns              = list daftar pilihan elemen (elements) dan juga status elemen jika dipilih (selectedElement) akan berwarna.

- What it Reports Upward    = Mengirim nama elemen yang dipilih ke RosterScreen menggunakan callback (String element).

# 3. Empty State

- Trigger                   = Reuse dan Readability.

- What it Owns              = Visual placeholder (ikon search, teks peringatan, dan reset).

- What it Reports Upward    = Mengirim pemicu jika user menekan tombol reset filter ke RosterScreen menggunakan callback onReset().

# 4. Empty State

- Trigger                   = Reuse dan Readability.

- What it Owns              = satu data karakter (character map/object) yang mempunyai nama, elemen, role, dan url gambar yang ditampilkan di letak kartu.

- What it Reports Upward    = Mengirim pemicu jika user menekan kartu karakter ke RosterScreen menggunakan callback onTap().
