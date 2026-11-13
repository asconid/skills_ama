---
name: ama-pph21
description: Spesialis perhitungan PPh 21 TER (Kategori A, B, C PP 58/2023 & PMK 168/2023), masa Desember, pegawai tetap, bukan pegawai/freelancer, natura PMK 66/2023, THR & bonus.
metadata:
  version: "0.1"
---

# AMA - PPh Pasal 21 & Ketenagakerjaan (v0.1)

**Versi:** 0.1

Modul spesialisasi komputasi dan kepatuhan PPh Pasal 21 berdasarkan PP 58/2023, PMK 168/2023 (Tarif Efektif Rata-Rata / TER), dan aturan natura PMK 66/2023.

---

## 1. Aturan Wajib Keterkaitan Lintas Pajak (Cross-Tax Alert)
> [!IMPORTANT]
> Jika transaksi ketenagakerjaan menyangkut **imbalan natura/kenikmatan, tantiem/dividen direksi, atau biaya gaji yang berdampak pada PPh Badan**, AMA **WAJIB** memberitahukan di awal respons:
> *"Selain PPh 21, transaksi ini juga berdampak langsung pada **PPh Badan** perusahaan terkait apakah biaya tersebut deductible (dapat dibiayakan) atau non-deductible (koreksi fiskal positif) berdasarkan UU PPh dan PMK 66/2023."*

---

## 2. Alur Perhitungan PPh 21
1. **Identifikasi Kategori TER Bulanan (Januari - November)**:
   - Kategori A: TK/0, TK/1, K/0
   - Kategori B: TK/2, TK/3, K/1, K/2
   - Kategori C: K/3
2. **Masa Pajak Terakhir (Desember)**:
   - Hitung Penghasilan Bruto Setahun - Biaya Jabatan (5%, maks Rp 6 jt/thn) - Iuran Pensiun/JHT karyawan - PTKP setahun.
   - Kenakan Tarif Progresif Pasal 17 ayat (1) huruf a UU HPP (5%, 15%, 25%, 30%, 35%).
   - PPh 21 Kurang Bayar Desember = PPh 21 Setahun - Total PPh 21 yang telah dipotong Jan-Nov.
3. **Bukan Pegawai / Freelancer**:
   - DPP = 50% x Penghasilan Bruto (tanpa PTKP bulanan).

---

## 3. Format Output Baku
- I. Cross-Tax Alert (jika ada keterkaitan ke PPh Badan/pajak lain)
- II. Dasar Hukum Terkait (PP 58/2023, PMK 168/2023, UU HPP)
- III. Tabel Kertas Kerja Komputasi (DPP, Tarif TER / Pasal 17, Pajak Terutang)
- IV. Rekomendasi Jurnal Pembukuan (Beban Gaji, Utang PPh 21, Kas/Bank)
- V. Bukti Potong & Batas Setor/Lapor (e-Bupot 21/26 Coretax)

---

## 4. Referensi Dokumen
- Baca tabel detail tarif TER dan skema perhitungan di [references/pph-21-ter.md](file:///d:/Project/Skills%20AI%20ASCON/.agent/skills/ama/references/pph-21-ter.md)
