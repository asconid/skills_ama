---
name: ama-help
description: Panduan bantuan navigasi komprehensif, daftar seluruh slash command / trigger AMA, contoh prompt penggunaan, dan kapabilitas konsultasi akuntansi pajak.
metadata:
  version: "0.1"
---

# AMA - Pusat Bantuan & Direktori Perintah (v0.1)

**Versi:** 0.1

Panduan lengkap penggunaan AMA (Asisten Manajemen & Akuntan Pajak Indonesia) untuk membantu Wajib Pajak Orang Pribadi dan Badan menavigasi konsultasi akuntansi dan perpajakan.

---

## 1. Daftar Lengkap Slash Command AMA

Gunakan perintah di bawah ini sesuai topik spesifik yang ingin Anda konsultasikan:

| Slash Command | Fungsi & Spesialisasi | Contoh Pertanyaan |
| :--- | :--- | :--- |
| **`/ama-simulasi`** | **Simulasi Laporan Keuangan (15 Kelompok Akun)** | `"/ama-simulasi buatkan proyeksi 2026 PT dagang omzet 15 Miliar"` |
| **`/ama`** | **Konsultasi Pajak Umum & Akuntansi** | `"/ama kami baru mendirikan PT, apa saja kewajiban perpajakannya?"` |
| **`/ama-pph21`** | **PPh 21 TER, Karyawan & Natura** | `"/ama-pph21 hitung TER PPh 21 Budi (K/1) gaji 10 jt dan bonus 15 jt"` |
| **`/ama-badan`** | **PPh Badan & Rekonsiliasi Fiskal** | `"/ama-badan omzet kami 12 Miliar laba 1,5 M, hitung fasilitas Pasal 31E"` |
| **`/ama-potput`** | **Withholding Tax (PPh 22, 23, 26, Final 4(2))** | `"/ama-potput sewa kantor 100 jt dan jasa konsultan 20 jt, berapa potongannya?"` |
| **`/ama-ppn`** | **PPN & e-Faktur Coretax** | `"/ama-ppn bagaimana perlakuan pajak masukan jika faktur diterbitkan terlambat?"` |
| **`/ama-umkm`** | **Skema Khusus UMKM PP 55/2022** | `"/ama-umkm omzet tahunan saya 900 jt, bagaimana perhitungan PPh Final 0,5%?"` |
| **`/ama-review`** | **Audit Kepatuhan, Ekualisasi & SP2DK** | `"/ama-review kami menerima SP2DK atas selisih omzet SPT Badan vs SPT PPN"` |
| **`/ama-klien`** | **Manajemen Klien & Tax Advisory Memo** | `"/ama-klien buatkan Tax Advisory Memo untuk klien PT Maju terkait fasilitas Pasal 31E"` |
| **`/ama-help`** | **Menu Bantuan & Direktori ini** | `"/ama-help"` |

---

## 2. Fitur Utama AMA

1. **Perhitungan Kertas Kerja Transparan**: Seluruh komputasi memuat DPP, tarif, dan formula hukum langkah demi langkah.
2. **Jurnal Akuntansi Pembukuan**: Menyertakan pencatatan debit/kredit (*Beban Pajak, Utang PPh, Kredit Pajak*).
3. **Peringatan Otomatis Keterkaitan Lintas Pajak (*Cross-Tax Alert*)**: Jika transaksi menyangkut pajak lain di luar trigger yang dipanggil, AMA akan mengingatkan terlebih dahulu di awal tanggapan.
4. **Kepatuhan Coretax DJP & UU HPP**: Berbasis PMK 168/2023 (TER PPh 21), PMK 66/2023 (Natura), PP 55/2022 (UMKM), dan UU Cipta Kerja/HPP.
