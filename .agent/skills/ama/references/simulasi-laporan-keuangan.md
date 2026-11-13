# Standar Simulasi Laporan Keuangan & Matriks 15 Kelompok Akun

Dokumen referensi ini mengatur format baku simulasi laporan keuangan (Neraca & Laba Rugi) berdasarkan 15 kelompok akun standar serta panduan integrasi lanjutan (*trigger chaining*) ke modul-modul analisis pajak AMA.

---

## 1. Matriks Standar 15 Kelompok Akun (Neraca & Laba Rugi)

Setiap simulasi laporan keuangan (termasuk proyeksi tahun 2026) **WAJIB** diklasifikasikan ke dalam 15 kelompok akun berikut:

| No | Urutan | Nama Kelompok Akun | Jenis Laporan | Keterangan Akun Umum |
| :---: | :---: | :--- | :--- | :--- |
| **1** | 1 | **ASSET LANCAR** | Aset (Neraca) | Kas, Bank, Deposito, Piutang Usaha, Persediaan Barang, Pajak Dibayar di Muka (PPh 22/23/25, PPN Masukan). |
| **2** | 2 | **ASSET TIDAK LANCAR** | Aset (Neraca) | Aset Tetap (Tanah, Gedung, Kendaraan, Mesin), Akumulasi Penyusutan, Aset Takberwujud / Amortisasi. |
| **3** | 3 | **ASSET LAIN-LAIN** | Aset (Neraca) | Jaminan Sewa, Uang Muka Investasi Jangka Panjang, Aset Lainnya di luar operasional langsung. |
| **4** | 1 | **KEWAJIBAN LANCAR** | Kewajiban (Neraca) | Utang Usaha, Utang Pajak (Utang PPh 21/23/25/29, Utang PPN), Beban Akrual, Utang Bank Jangka Pendek. |
| **5** | 2 | **KEWAJIBAN TIDAK LANCAR** | Kewajiban (Neraca) | Utang Bank Jangka Panjang, Utang Pemegang Saham, Liabilitas Imbalan Kerja Karyawan Jangka Panjang. |
| **6** | 1 | **EKUITAS** | Ekuitas (Neraca) | Modal Saham Disetor, Tambahan Modal Disetor, Saldo Laba Tahun Lalu, Laba (Rugi) Periode Berjalan. |
| **7** | 1 | **PEREDARAN USAHA** | Pendapatan Usaha (L/R) | Penjualan Bruto Barang/Jasa, Retur & Potongan Penjualan (Revenue Operasional Utama). |
| **8** | 1 | **HARGA POKOK PENJUALAN** | HPP (L/R) | Biaya Bahan Baku, Upah Langsung Pabrikasi/Tenaga Kerja Proyek, Biaya Overhead Pabrik (BOP). |
| **9** | 1 | **BEBAN PENJUALAN** | Biaya Usaha Lainnya (L/R) | Biaya Iklan, Promosi & Pemasaran, Komisi Agen Penjualan, Biaya Ekspedisi/Pengiriman Logistik. |
| **10** | 2 | **BEBAN UMUM DAN ADMINISTRASI** | Biaya Usaha Lainnya (L/R) | Gaji & Tunjangan Staf/Direksi, Sewa Gedung Kantor, Beban IT/Jasa Profesional, Penyusutan, Natura Kantor. |
| **11** | 1 | **PENGHASILAN DARI LUAR USAHA** | Pendapatan Luar Usaha (L/R) | Bunga Jasa Giro/Deposito, Laba Selisih Kurs, Dividen Investasi, Keuntungan Penjualan Aset Tetap. |
| **12** | 1 | **BIAYA DARI LUAR USAHA** | Biaya Luar Usaha (L/R) | Beban Bunga Pinjaman Bank, Administrasi Bank, Rugi Selisih Kurs, Rugi Pelepasan Aset. |
| **13** | 1 | **BAGIAN LABA (RUGI) PERUSAHAAN ASOSIASI** | Laba (Rugi) Lainnya (L/R) | Pembagian Laba atau Penanggungan Rugi dari entitas asosiasi berdasarkan kepemilikan modal (metode ekuitas). |
| **14** | 2 | **BEBAN (MANFAAT) PAJAK PENGHASILAN** | Laba (Rugi) Lainnya (L/R) | Beban Pajak Kini (PPh Badan Terutang) dan Pajak Tangguhan (*Deferred Tax*). |
| **15** | 3 | **POS LUAR BIASA** | Laba (Rugi) Lainnya (L/R) | Kerugian/keuntungan yang timbul dari peristiwa yang sifatnya tidak biasa dan jarang terjadi (bencana alam, force majeure). |

---

## 2. Format Penyajian Simulasi Laporan Keuangan

Setiap kali menjalankan simulasi, sajikan hasil dalam format tabel yang seimbang (*balanced*):

### A. Laporan Laba Rugi Komprehensif (Simulasi)
```markdown
| No | Kelompok Akun | Nilai Simulasi (Rp) | % thd Omzet |
|---|---|---|---|
| 7 | PEREDARAN USAHA | Rp [X] | 100.0% |
| 8 | HARGA POKOK PENJUALAN (HPP) | (Rp [X]) | [X]% |
| **LABA KOTOR** | | **Rp [X]** | **[X]%** |
| 9 | BEBAN PENJUALAN | (Rp [X]) | [X]% |
| 10 | BEBAN UMUM DAN ADMINISTRASI | (Rp [X]) | [X]% |
| **LABA USAHA OPERASIONAL** | | **Rp [X]** | **[X]%** |
| 11 | PENGHASILAN DARI LUAR USAHA | Rp [X] | [X]% |
| 12 | BIAYA DARI LUAR USAHA | (Rp [X]) | [X]% |
| 13 | BAGIAN LABA (RUGI) ASOSIASI | Rp [X] | [X]% |
| **LABA SEBELUM PAJAK & POS LUAR BIASA** | | **Rp [X]** | **[X]%** |
| 14 | BEBAN PAJAK PENGHASILAN | (Rp [X]) | [X]% |
| 15 | POS LUAR BIASA | Rp 0 | 0.0% |
| **LABA BERSIH TAHUN BERJALAN** | | **Rp [X]** | **[X]%** |
```

### B. Laporan Posisi Keuangan / Neraca (Simulasi)
```markdown
| No | Kelompok Aset | Nilai (Rp) | No | Kelompok Kewajiban & Ekuitas | Nilai (Rp) |
|---|---|---|---|---|---|
| 1 | ASSET LANCAR | Rp [X] | 4 | KEWAJIBAN LANCAR | Rp [X] |
| 2 | ASSET TIDAK LANCAR | Rp [X] | 5 | KEWAJIBAN TIDAK LANCAR | Rp [X] |
| 3 | ASSET LAIN-LAIN | Rp [X] | 6 | EKUITAS | Rp [X] |
| **TOTAL ASET** | | **Rp [TOTAL]** | **TOTAL KEWAJIBAN & EKUITAS** | | **Rp [TOTAL]** |
```
*(Wajib dipastikan: TOTAL ASET = TOTAL KEWAJIBAN & EKUITAS)*

---

## 3. Matriks Sambungan / Chaining ke Triggers Lainnya

Setelah simulasi 15 kelompok akun selesai dibuat, sediakan panduan interaktif bagi pengguna untuk melanjutkan simulasi ke modul pajak spesifik:

1. **Lanjut ke `/ama-badan` (PPh Badan & Rekonsiliasi Fiskal)**:
   - Ambil angka **Peredaran Usaha (No 7)** dan **Laba Sebelum Pajak**.
   - Identifikasi potensi koreksi fiskal positif pada **Beban Umum & Administrasi (No 10)** (misal: natura direksi PMK 66/2023, biaya representasi/entertainment tanpa daftar nominatif).
   - Terapkan fasilitas Pasal 31E UU PPh untuk menghitung PPh Badan terutang riil.

2. **Lanjut ke `/ama-pph21` (Gaji & Pemotongan TER Karyawan)**:
   - Bedah pos **Beban Umum & Administrasi (No 10)** yang dialokasikan untuk Gaji Karyawan, Tunjangan, THR, dan Bonus.
   - Lakukan simulasi TER PPh 21 bulanan dan rekonsiliasi masa pajak terakhir (Desember).

3. **Lanjut ke `/ama-potput` (Withholding Tax PPh 23 & Final 4(2))**:
   - Ekstrak biaya sewa kantor/gudang pada pos **Beban Umum (No 10)** untuk simulasi PPh Final Pasal 4(2) (10%).
   - Ekstrak biaya jasa profesional/IT/ekspedisi pada pos **Beban Penjualan (No 9)** dan **Beban Umum (No 10)** untuk simulasi PPh 23 (2%).

4. **Lanjut ke `/ama-ppn` (Simulasi PPN & e-Faktur)**:
   - Uji Pajak Keluaran (PK) 11%/12% dari **Peredaran Usaha (No 7)**.
   - Uji Pajak Masukan (PM) dari pembelian persediaan di **HPP (No 8)** dan perolehan **Aset Tidak Lancar (No 2)**.
   - Hitung posisi Kurang/Lebih Bayar PPN bulanan.

5. **Lanjut ke `/ama-umkm` (Skema Khusus PP 55/2022)**:
   - Jika **Peredaran Usaha (No 7)** < Rp 4,8 Miliar dan entitas memenuhi syarat, bandingkan efisiensi PPh Final 0,5% vs PPh Badan tarif umum 22% (Pasal 31E).

6. **Lanjut ke `/ama-review` (Ekualisasi Pajak & Audit Readiness)**:
   - Lakukan ekualisasi silang: Omzet Laba Rugi vs Penyerahan PPN, Biaya Tenaga Kerja vs Objek PPh 21, Biaya Jasa vs Objek PPh 23.
   - Simulasikan mitigasi risiko SP2DK dari KPP sebelum tahun buku berakhir.
