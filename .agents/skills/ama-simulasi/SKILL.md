---
name: ama-simulasi
description: Simulasi proyeksi laporan keuangan komprehensif (Laba Rugi & Neraca 15 kelompok akun baku) dan integrasi lanjutan (trigger chaining) ke modul analisis pajak AMA.
metadata:
  version: "0.1"
---

# AMA - Simulasi Laporan Keuangan & Matriks 15 Kelompok Akun (v0.1)

**Versi:** 0.1

Modul khusus untuk menyusun simulasi dan proyeksi laporan keuangan (Laba Rugi & Neraca yang seimbang) berdasarkan **15 kelompok akun standar**, serta menyediakan sambungan otomatis (*chaining*) ke modul analisis perpajakan AMA lainnya.

---

## 1. Matriks Standar 15 Kelompok Akun (Neraca & Laba Rugi)

Setiap simulasi laporan keuangan **WAJIB** menyajikan ke-15 kelompok akun berikut:

| No | Urutan | Nama Kelompok Akun | Jenis Laporan | Keterangan Akun Umum |
| :---: | :---: | :--- | :--- | :--- |
| **1** | 1 | **ASSET LANCAR** | Aset (Neraca) | Kas, Bank, Deposito, Piutang Usaha, Persediaan, Pajak Dibayar di Muka (PPh 22/23/25, PPN Masukan). |
| **2** | 2 | **ASSET TIDAK LANCAR** | Aset (Neraca) | Aset Tetap (Tanah, Bangunan, Kendaraan, Mesin), Akumulasi Penyusutan, Aset Takberwujud / Amortisasi. |
| **3** | 3 | **ASSET LAIN-LAIN** | Aset (Neraca) | Jaminan Sewa, Uang Muka Investasi Jangka Panjang, Aset Lainnya di luar operasional langsung. |
| **4** | 1 | **KEWAJIBAN LANCAR** | Kewajiban (Neraca) | Utang Usaha, Utang Pajak (Utang PPh 21/23/25/29, Utang PPN), Beban Akrual, Utang Bank Jangka Pendek. |
| **5** | 2 | **KEWAJIBAN TIDAK LANCAR** | Kewajiban (Neraca) | Utang Bank Jangka Panjang, Utang Pemegang Saham, Liabilitas Imbalan Kerja Karyawan Jangka Panjang. |
| **6** | 1 | **EKUITAS** | Ekuitas (Neraca) | Modal Saham Disetor, Tambahan Modal Disetor, Saldo Laba Ditahan, Laba (Rugi) Periode Berjalan. |
| **7** | 1 | **PEREDARAN USAHA** | Pendapatan Usaha (L/R) | Penjualan Bruto Barang/Jasa, Retur & Potongan Penjualan (Revenue Operasional Utama). |
| **8** | 1 | **HARGA POKOK PENJUALAN** | HPP (L/R) | Biaya Bahan Baku, Upah Langsung Tenaga Kerja, Biaya Overhead Pabrik (BOP). |
| **9** | 1 | **BEBAN PENJUALAN** | Biaya Usaha Lainnya (L/R) | Biaya Iklan, Promosi & Pemasaran, Komisi Penjualan, Biaya Ekspedisi/Pengiriman Logistik. |
| **10** | 2 | **BEBAN UMUM DAN ADMINISTRASI** | Biaya Usaha Lainnya (L/R) | Gaji & Tunjangan Karyawan/Direksi, Sewa Gedung Kantor, Jasa Profesional/IT, Penyusutan, Natura Kantor. |
| **11** | 1 | **PENGHASILAN DARI LUAR USAHA** | Pendapatan Luar Usaha (L/R) | Bunga Jasa Giro/Deposito, Laba Selisih Kurs, Dividen, Keuntungan Penjualan Aset Tetap. |
| **12** | 1 | **BIAYA DARI LUAR USAHA** | Biaya Luar Usaha (L/R) | Beban Bunga Pinjaman Bank, Administrasi Bank, Rugi Selisih Kurs, Rugi Pelepasan Aset. |
| **13** | 1 | **BAGIAN LABA (RUGI) PERUSAHAAN ASOSIASI** | Laba (Rugi) Lainnya (L/R) | Pembagian Laba atau Rugi dari entitas asosiasi berdasarkan metode ekuitas. |
| **14** | 2 | **BEBAN (MANFAAT) PAJAK PENGHASILAN** | Laba (Rugi) Lainnya (L/R) | Beban Pajak Kini (PPh Badan Terutang) dan Pajak Tangguhan (*Deferred Tax*). |
| **15** | 3 | **POS LUAR BIASA** | Laba (Rugi) Lainnya (L/R) | Keuntungan/kerugian dari kejadian tidak biasa dan jarang terjadi (bencana alam, force majeure). |

---

## 2. Format Output Simulasi

Sajikan hasil simulasi dalam tabel komparatif dan seimbang:
1. **Laporan Laba Rugi Komprehensif (Kelompok 7 s.d. 15)** lengkap dengan persentase terhadap omzet.
2. **Laporan Posisi Keuangan / Neraca (Kelompok 1 s.d. 6)** dengan prinsip: `TOTAL ASET = TOTAL KEWAJIBAN + EKUITAS`.

---

## 3. Menu Sambungan (*Trigger Chaining*) Wajib di Akhir Output

Di bagian akhir setiap simulasi, **WAJIB** sertakan menu berikut agar pengguna dapat langsung menyambungkan simulasi ke analisis pajak:

```markdown
---
### 🔗 Lanjutkan Simulasi ke Modul Pajak AMA:
Ketik perintah berikut untuk menganalisis angka hasil simulasi di atas:
- **`/ama-badan`** : Lakukan rekonsiliasi fiskal dan hitung PPh Badan (Pasal 31E) dari Laba Komersial simulasi.
- **`/ama-pph21`** : Bedah pos Beban Umum & Administrasi (No 10) untuk kalkulasi PPh 21 TER karyawan/direksi.
- **`/ama-potput`** : Hitung Withholding Tax (PPh 23 jasa & PPh Final 4(2) sewa kantor) dari pos beban operasional.
- **`/ama-ppn`** : Uji kepatuhan PPN (Pajak Keluaran atas Peredaran Usaha & Pajak Masukan atas HPP/Aset).
- **`/ama-review`** : Jalankan ekualisasi silang antar-SPT dan simulasi audit kepatuhan risiko SP2DK.
```

---

## 4. Referensi Dokumen
- Baca panduan lengkap simulasi di [references/simulasi-laporan-keuangan.md](file:///d:/Project/Skills%20AI%20ASCON/.agent/skills/ama/references/simulasi-laporan-keuangan.md)
