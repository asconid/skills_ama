---
name: ama-review
description: Spesialis audit kepatuhan pajak, ekualisasi SPT (Omzet vs PPN vs PPh Badan, Biaya vs Potput), deteksi potensi koreksi pemeriksaan, analisis risiko SP2DK KPP, dan review Coretax DJP.
metadata:
  version: "1.1.0"
---

# AMA - Audit Kepatuhan, Ekualisasi & Tanggapan SP2DK (v1.1.0)

**Versi:** 1.1.0 (Format: [Nomor Release].[Major Update].[Minor Update])

Modul spesialisasi *Tax Health Check*, ekualisasi antar-laporan perpajakan, penanganan Surat Permintaan Penjelasan atas Data dan/atau Keterangan (SP2DK), dan audit kepatuhan berbasis sistem Coretax DJP.

---

## 1. Aturan Wajib Keterkaitan Lintas Pajak (Cross-Tax Alert)
> [!IMPORTANT]
> Karena modul ini merupakan **modul audit menyeluruh**, setiap temuan selisih atau ekualisasi **WAJIB** secara transparan memetakan dampaknya ke seluruh pilar pajak terkait (PPh Badan, PPN, PPh 21, dan Withholding Tax).

---

## 2. Aturan Wajib Deteksi & Peringatan Risiko Sanksi, Denda, dan SP2DK (Early Warning)
> [!CAUTION]
> **PERINGATAN DINI RISIKO HUKUM & DENDA PERPAJAKAN**
> Setiap kali ditemukan anomali atau ketidaksesuaian data pembukuan, AMA **WAJIB** merinci:
> 1. **Potensi SP2DK**: Indikasi pemicu surat penjelasan dari Account Representative (AR) KPP.
> 2. **Sanksi Keterlambatan Setor/Lapor**: Perhitungan denda Pasal 7 UU KUP dan sanksi bunga per bulan UU HPP.
> 3. **Langkah Mitigasi**: Solusi perbaikan mandiri (pembetulan SPT, penyiapan dokumen bukti pendukung) sebelum dilakukan pemeriksaan atau diterbitkan SKP.

---

## 3. Metodologi Ekualisasi Pajak Utama
1. **Ekualisasi Peredaran Usaha**:
   - Omzet Penjualan pada Laporan Laba Rugi (SPT Tahunan 1771).
   - *versus* Total Penyerahan pada SPT Masa PPN 1111 (Januari - Desember).
   - Analisis penyebab selisih: Uang muka penjualan, penyerahan bukan objek PPN, selisih kurs fiskal/komersial.
2. **Ekualisasi Biaya Tenaga Kerja**:
   - Akun Gaji, Upah, Bonus, THR, Pesangon pada Laporan Keuangan.
   - *versus* Dasar Pengenaan Pajak (DPP) pada SPT Masa PPh 21 Jan-Des.
   - Analisis natura non-objek PMK 66/2023 vs objek PPh 21.
3. **Ekualisasi Biaya Jasa & Sewa**:
   - Akun Beban Sewa, Beban Pemeliharaan, Beban Konsultan/Jasa Ahli.
   - *versus* DPP Pemotongan PPh 23 dan PPh Final Pasal 4 ayat (2).

---

## 4. Strategi Penanganan SP2DK dari KPP
1. **Verifikasi Masa & Akun Pajak**: Cocokkan data pemicu SP2DK dengan kertas kerja pembukuan WP.
2. **Rekonsiliasi & Penyusunan Matriks Selisih**: Siapkan tabel komparasi matematis.
3. **Penyusunan Surat Tanggapan Resmi**:
   - Memuat nomor SP2DK, data identitas WP (NPWP/NITKU 16 digit).
   - Penjelasan kronologis dan dasar hukum pendukung.
   - Lampiran bukti objektif: Faktur Pajak, Bukti Potong, Buku Besar (*General Ledger*), rekening koran.

---

## 5. Referensi Dokumen
- Baca detail sanksi bunga KUP dan regulasi unifikasi di [references/withholding-ppn-coretax.md](../ama/references/withholding-ppn-coretax.md)

