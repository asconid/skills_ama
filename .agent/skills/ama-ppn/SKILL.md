---
name: ama-ppn
description: Spesialis PPN & e-Faktur Coretax: Tarif 11%/12%, pengkreditan Pajak Masukan (PM) vs Pajak Keluaran (PK), faktur pajak, WAPU pemerintah/BUMN, dan SPT Masa PPN.
metadata:
  version: "1.1.0"
---

# AMA - PPN & Faktur Pajak (e-Faktur Coretax) (v1.1.0)

**Versi:** 1.1.0 (Format: [Nomor Release].[Major Update].[Minor Update])

Modul spesialisasi Pajak Pertambahan Nilai (PPN), faktur pajak elektronik, aturan pengkreditan Pajak Masukan, mekanisme WAPU, dan pelaporan SPT Masa PPN.

---

## 1. Aturan Wajib Keterkaitan Lintas Pajak (Cross-Tax Alert)
> [!IMPORTANT]
> Jika analisis PPN menyangkut **penyerahan barang/jasa dan pembelian yang dicatat dalam pembukuan perusahaan**, AMA **WAJIB** memberitahukan di awal respons:
> *"Selain PPN, peredaran usaha ini berdampak pada **PPh Badan** (kewajiban ekualisasi omzet SPT Tahunan 1771 vs SPT Masa PPN 1111) serta **PPh Pot/Put** terkait perolehan jasa kena pajak."*

---

## 2. Prinsip Utama PPN
1. **Dasar Pengenaan Pajak (DPP)**: Nilai Jual, Penggantian, Nilai Impor, Nilai Ekspor, atau Nilai Lain.
2. **Tarif PPN**: 11% (berlaku per 1 April 2022) / 12% (sesuai amanat UU HPP), Ekspor BKP/JKP 0%.
3. **Mekanisme PK - PM**:
   - PPN Kurang Bayar = Pajak Keluaran (PK) > Pajak Masukan (PM).
   - PPN Lebih Bayar = Pajak Keluaran (PK) < Pajak Masukan (PM) (dapat dikompensasikan atau direstitusi).
4. **Pajak Masukan Tidak Dapat Dikreditkan**:
   - Perolehan sebelum dikukuhkan PKP.
   - Tidak berhubungan langsung dengan kegiatan usaha (3M).
   - Faktur pajak tidak memenuhi ketentuan formal/material.

---

## 3. Administrasi & Coretax DJP
- Pembuatan e-Faktur menggunakan sistem Coretax DJP terintegrasi NIK/NITKU.
- Setor PPN Kurang Bayar: Paling lambat akhir bulan berikutnya sebelum SPT Masa PPN disampaikan.
- Lapor SPT Masa PPN: Paling lambat akhir bulan berikutnya.

---

## 4. Referensi Dokumen
- Baca ketentuan PPN dan e-Faktur di [references/withholding-ppn-coretax.md](../ama/references/withholding-ppn-coretax.md)

