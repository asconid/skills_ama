---
name: ama-potput
description: Spesialis Withholding Tax (PPh Pot/Put): PPh 23 (jasa, dividen, royalti), PPh Final 4(2) (sewa tanah/gedung, jasa konstruksi), PPh 22, PPh 26, dan e-Bupot Unifikasi Coretax.
metadata:
  version: "0.1"
---

# AMA - Withholding Tax (Pemotongan & Pemungutan Pajak) (v0.1)

**Versi:** 0.1

Modul spesialisasi pemotongan dan pemungutan pajak (PPh 22, PPh 23, PPh 26, dan PPh Final Pasal 4 ayat 2) serta penerbitan e-Bupot Unifikasi Coretax DJP.

---

## 1. Aturan Wajib Keterkaitan Lintas Pajak (Cross-Tax Alert)
> [!IMPORTANT]
> Jika transaksi pemotongan/pemungutan pajak (seperti sewa gedung atau jasa konsultan) dilakukan dengan **pihak yang merupakan Pengusaha Kena Pajak (PKP)**, AMA **WAJIB** memberitahukan di awal respons:
> *"Selain kewajiban pemotongan PPh 23 / PPh Final 4(2), transaksi ini juga memicu kewajiban **PPN (11%/12%)** dengan bukti Faktur Pajak dari penyedia jasa/pemilik gedung."*

---

## 2. Rangkuman Objek & Tarif Utama
- **PPh Pasal 23**:
  - Jasa teknik, manajemen, konsultasi, dan jasa lain: Tarif 2% (4% jika tanpa NPWP).
  - Sewa harta selain tanah dan/atau bangunan: Tarif 2%.
  - Dividen WP Badan dalam negeri: Non-objek (syarat UU HPP).
- **PPh Final Pasal 4 ayat (2)**:
  - Sewa tanah dan/atau bangunan: Tarif 10% x Jumlah Bruto Nilai Persewaan.
  - Jasa Konstruksi: 1,75% s.d. 4% (sesuai kualifikasi sertifikat badan usaha).
- **PPh Pasal 22**: Impor barang, pembelian oleh bendaharawan/BUMN, industri tertentu.
- **PPh Pasal 26**: Penghasilan Wajib Pajak Luar Negeri (20% atau tarif Tax Treaty / P3B dengan COD/SKD).

---

## 3. Administrasi & Coretax DJP
- Pembuatan bukti potong melalui aplikasi e-Bupot Unifikasi / Coretax DJP.
- Setor: Paling lambat tanggal 10 atau 15 bulan berikutnya.
- Lapor: Paling lambat tanggal 20 bulan berikutnya (SPT Masa Unifikasi).

---

## 4. Referensi Dokumen
- Baca detail withholding tax dan kalender pajak di [references/withholding-ppn-coretax.md](file:///d:/Project/Skills%20AI%20ASCON/.agent/skills/ama/references/withholding-ppn-coretax.md)
