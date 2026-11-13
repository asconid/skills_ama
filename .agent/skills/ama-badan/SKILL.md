---
name: ama-badan
description: Spesialis PPh Badan tarif 22%, fasilitas pengurangan tarif Pasal 31E UU PPh, koreksi fiskal positif & negatif, laba komersial vs fiskal, kompensasi rugi, dan kredit pajak.
metadata:
  version: "1.1.0"
---

# AMA - PPh Badan & Rekonsiliasi Fiskal (v1.1.0)

**Versi:** 1.1.0 (Format: [Nomor Release].[Major Update].[Minor Update])

Modul spesialisasi penghitungan PPh Badan tahunan, penerapan fasilitas Pasal 31E UU PPh, koreksi fiskal (positif/negatif), dan kredit pajak (PPh 22, 23, 25).

---

## 1. Aturan Wajib Keterkaitan Lintas Pajak (Cross-Tax Alert)
> [!IMPORTANT]
> Jika peredaran bruto dan beban usaha menyangkut **transaksi sewa/jasa (objek PPh Potput) atau peredaran bruto melebihi Rp 4,8 Miliar (kewajiban PKP & PPN)**, AMA **WAJIB** memberitahukan di awal respons:
> *"Selain PPh Badan, transaksi ini terkait dengan **PPN** (ekualisasi omzet SPT Badan vs SPT PPN) serta **PPh Pot/Put (PPh 23 & Final 4(2))** atas pos beban sewa/jasa yang wajib dipotong."*

---

## 2. Alur Rekonsiliasi Fiskal & Komputasi PPh Badan
1. **Laba Bersih Komersial Sebelum Pajak**
2. **Koreksi Fiskal Positif**:
   - Biaya natura/kenikmatan non-deductible (PMK 66/2023).
   - Biaya representasi/entertainment tanpa daftar nominatif.
   - Sanksi administrasi pajak (bunga/denda).
   - Selisih penyusutan komersial di atas fiskal.
3. **Koreksi Fiskal Negatif**:
   - Penghasilan yang dikenakan PPh Final (contoh: sewa tanah/bangunan, bunga deposito).
   - Penghasilan bukan objek pajak (dividen sesuai syarat UU HPP).
   - Selisih penyusutan fiskal di atas komersial.
4. **Penghasilan Neto Fiskal - Kompensasi Rugi Fiskal = PKP (Penghasilan Kena Pajak)**.
5. **Penerapan Tarif**:
   - Omzet s.d. Rp 4,8 Miliar: Fasilitas 50% x 22% = 11% x Seluruh PKP.
   - Omzet Rp 4,8 Miliar s.d. Rp 50 Miliar: Sebagian PKP mendapat fasilitas (proporsi 4,8 M / Omzet), sisa PKP tarif normal 22%.
   - Omzet di atas Rp 50 Miliar: Seluruh PKP kena tarif normal 22%.

---

## 3. Referensi Dokumen
- Baca panduan lengkap rekonsiliasi fiskal dan Pasal 31E di [references/pph-badan-umkm.md](../ama/references/pph-badan-umkm.md)

