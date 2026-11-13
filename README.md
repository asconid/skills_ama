# AMA - Asisten Manajemen & Akuntan Pajak Indonesia (v0.1)

Kumpulan *Agent Skills* profesional untuk konsultasi akuntansi dan perpajakan Indonesia berbasis regulasi termutakhir (pasca-UU Harmonisasi Peraturan Perpajakan / UU HPP, PMK 168/2023 TER PPh 21, PP 55/2022 UMKM, PMK 66/2023 Natura, UU KUP, dan Coretax DJP).

---

## 🚀 Daftar Slash Command / Triggers

| Perintah | Mode & Spesialisasi | Fokus Utama |
| :--- | :--- | :--- |
| **`/ama-simulasi`** | **Simulasi Laporan Keuangan** | Simulasi proyeksi Neraca & Laba Rugi seimbang berbasis 15 kelompok akun standar serta *trigger chaining*. |
| **`/ama`** | **Konsultasi Pajak Umum** | Konsultasi umum, advisory strategi pajak, pemetaan kewajiban entitas baru, dan akuntansi pajak. |
| **`/ama-pph21`** | **PPh 21 & Ketenagakerjaan** | Komputasi TER bulanan (Kategori A, B, C), masa pajak terakhir (Desember), skema bukan pegawai, natura, bonus & THR. |
| **`/ama-badan`** | **PPh Badan & Rekonsiliasi** | Tarif PPh Badan 22%, fasilitas pengurangan tarif Pasal 31E UU PPh, koreksi fiskal positif & negatif, dan kompensasi rugi. |
| **`/ama-potput`** | **Withholding Tax (Pot/Put)** | Pemotongan/pemungutan PPh 23 (jasa, dividen, royalti), PPh Final 4(2) (sewa gedung, jasa konstruksi), PPh 22, PPh 26, dan e-Bupot Unifikasi. |
| **`/ama-ppn`** | **PPN & e-Faktur Coretax** | PPN 11%/12%, pengkreditan Pajak Masukan (PM) vs Pajak Keluaran (PK), faktur pajak, WAPU pemerintah/BUMN, dan SPT Masa PPN. |
| **`/ama-umkm`** | **Skema Khusus UMKM** | PPh Final 0,5% PP 55/2022, threshold omzet Rp 500 juta bebas pajak untuk WPOP, dan batasan jangka waktu fasilitas. |
| **`/ama-review`** | **Audit & SP2DK Review** | Ekualisasi silang antar-SPT (Omzet vs PPN vs PPh Badan, Biaya vs Potput), deteksi potensi koreksi, dan penyusunan tanggapan SP2DK. |
| **`/ama-help`** | **Pusat Bantuan & Direktori** | Panduan navigasi seluruh trigger, contoh prompt pemanggilan, dan fitur unggulan. |

---

## 🌟 Fitur Unggulan

1. **Simulasi Laporan Keuangan 15 Kelompok Akun Baku**:
   Menyusun Laporan Posisi Keuangan (Neraca) dan Laba Rugi yang seimbang (*Total Aset = Total Kewajiban + Ekuitas*) dengan opsi sambungan langsung (*chaining*) ke modul pajak.
2. **Peringatan Otomatis Keterkaitan Lintas Pajak (*Cross-Tax Alert*)**:
   Jika suatu transaksi menyangkut jenis pajak lain di luar trigger yang dipanggil, AMA secara proaktif memberitahukan di awal respons.
3. **Peringatan Dini Sanksi & SP2DK (*Tax Penalty Early Warning*)**:
   Mendeteksi secara dini potensi penerbitan SP2DK dari KPP, denda administrasi Pasal 7 KUP, dan sanksi bunga per bulan UU HPP, serta memberikan rekomendasi perbaikan sebelum pemeriksaan.
4. **Komputasi Kertas Kerja Transparan & Jurnal Akuntansi**:
   Menyajikan langkah-langkah perhitungan secara detail (DPP, tarif, nilai pajak) serta ayat jurnal pembukuan (*Beban Pajak, Utang PPh, Kredit Pajak*).
5. **Kesiapan Sistem Coretax DJP**:
   Mendukung integrasi NIK/NITKU 16 digit, e-Bupot Unifikasi, dan e-Faktur Coretax.

---

## 📁 Struktur Direktori

```text
├── .agent/skills/          # Format direktori skills untuk Google Antigravity & Gemini CLI
│   ├── ama/
│   ├── ama-badan/
│   ├── ama-help/
│   ├── ama-potput/
│   ├── ama-pph21/
│   ├── ama-ppn/
│   ├── ama-review/
│   ├── ama-simulasi/
│   ├── ama-umkm/
│   └── skill-creator/
├── .agents/skills/         # Format kompatibilitas multi-agent platform
└── README.md
```

---

## 📄 Lisensi
Hak Cipta © 2026 ASCON.
