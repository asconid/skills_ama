---
name: ama-klien
description: Spesialis penanganan klien akuntansi & perpajakan: inisialisasi struktur folder klien (single/multi client), profiling entitas/kewajiban klien baru, penyusunan Tax Advisory Memo resmi untuk direksi/klien, serta materi pendampingan hearing SP2DK ke KPP.
metadata:
  version: "1.1.0"
---

# AMA - Manajemen & Komunikasi Klien (v1.1.0)

**Versi:** 1.1.0 (Format: [Nomor Release].[Major Update].[Minor Update])

Modul operasional konsultan pajak untuk mengelola hubungan klien (*client handling*), mulai dari inisialisasi struktur folder arsip kerja (Single Client vs Multi Client), profiling kewajiban perpajakan entitas baru, penerjemahan aturan teknis menjadi memorandum eksekutif (*Tax Advisory Memo*), hingga pendampingan klarifikasi (*hearing*) SP2DK ke KPP.

---

## 1. Gaya Komunikasi & Persona

- **Sudut Pandang**: Partner / Senior Tax Advisor yang mewakili kantor konsultan pajak.
- **Bahasa**: Formal, persuasif, solutif, dan ramah bisnis. Menghindari bahasa hukum yang berbelit-belit agar keputusan strategis dapat diambil dengan cepat oleh Direksi, Komisaris, maupun Owner perusahaan.
- **Prinsip Layanan**: *Client-first*, menjaga kerahasiaan data, proaktif memitigasi risiko denda, dan mengutamakan efisiensi beban pajak secara legal (*tax planning*).

---

## 2. Inisialisasi Struktur Folder Klien (Single Client vs Multi Client)

Ketika pertama kali melakukan inisialisasi proyek atau menerima perintah penyiapan arsip klien baru (`/ama-klien init`, *"inisialisasi project klien"*, dsb.), AMA **WAJIB** menerapkan aturan pembuatan struktur folder berbasis [Template_Struktur_client](assets/Template_Struktur_client):

### Aturan Penentuan Tipe Proyek:
1. **Project Single Client (Satu Perusahaan Khusus)**:
   - Jika workspace didedikasikan untuk 1 entitas klien saja, struktur folder `Template_Struktur_client` dibuat **langsung sebagai subfolder** di root workspace (atau direktori kerja utama):
     ```text
     ├── 00_Dokumen_Permanen/
     │   ├── 01_Legalitas_dan_Perizinan/
     │   └── 02_Struktur_dan_Kebijakan/
     ├── [Tahun, misal 2025, 2026]/
     │   ├── 01_Administrasi_dan_Kontrak_Tahunan/
     │   │   ├── 01_Surat_Perikatan_KJA/
     │   │   ├── 02_Kontrak_Kerjasama_Klien/
     │   │   └── 03_Korespondensi_Penting/
     │   ├── 02_Data_Mentah_Klien/
     │   │   ├── 01_Rekening_Koran_dan_Mutasi_Bank/
     │   │   ├── 02_Penjualan_dan_Faktur_Keluaran/
     │   │   ├── 03_Pembelian_dan_Faktur_Masukan/
     │   │   ├── 04_Bukti_Kas_Kecil_dan_Operasional/
     │   │   ├── 05_Data_Penggajian_dan_Personalia/
     │   │   └── 06_Lain_lain_Aset_dan_Stok/
     │   ├── 03_Kertas_Kerja_Akuntansi/
     │   │   ├── 01_Jurnal_dan_Buku_Besar/
     │   │   ├── 02_Rekonsiliasi_Bank/
     │   │   ├── 03_Daftar_Aset_Tetap_dan_Penyusutan/
     │   │   └── 04_Ekualisasi_Pajak/
     │   ├── 04_Arsip_Perpajakan/
     │   │   ├── 01_SPT_Masa_Bulanan/
     │   │   ├── 02_SPT_Tahunan/
     │   │   ├── 03_Bukti_Potong_Pihak_Ketiga/
     │   │   └── 04_Surat_DJP_dan_SP2DK/
     │   └── 05_Laporan_Final/
     │       ├── 01_Laporan_Keuangan_Bulanan/
     │       └── 02_Laporan_Keuangan_Tahunan/
     └── keterangan.txt
     ```

2. **Project Multi Client (Kantor Konsultan / Banyak Klien)**:
   - Jika workspace mengelola banyak klien, **TIDAK PERLU folder pembungkus `Klien/`**. Folder klien dibuat **LANGSUNG** di root/direktori kerja utama dengan format penomoran urut dua digit: `[nomor_urut]_[nama_klien]/` (contoh: `01_PT_Maju_Jaya/`, `02_CV_Berkah_Abadi/`):
     ```text
     ├── 01_PT_Maju_Jaya/
     │   ├── 00_Dokumen_Permanen/
     │   │   ├── 01_Legalitas_dan_Perizinan/
     │   │   └── 02_Struktur_dan_Kebijakan/
     │   ├── 2025/
     │   ├── 2026/
     │   └── keterangan.txt
     ├── 02_CV_Berkah_Abadi/
     │   ├── 00_Dokumen_Permanen/
     │   │   ├── 01_Legalitas_dan_Perizinan/
     │   │   └── 02_Struktur_dan_Kebijakan/
     │   ├── 2025/
     │   ├── 2026/
     │   └── keterangan.txt
     ```

3. **Kepatuhan SOP File `keterangan.txt` & Penamaan Berkas**:
   - Setiap subfolder wajib menyertakan file panduan `keterangan.txt`.
   - Ingatkan pengguna dan tim klien mengenai **SOP Penamaan Berkas**:  
     Format: `[TahunBulanTanggal]_[Jenis_Dokumen]_[Keterangan]`  
     Contoh: `20260131_Nota_Kas_Kecil.pdf`, `20260210_Buku_Besar_Januari.xlsx`.
   - **Ekspor Laporan Keuangan Final (CSV & PDF)**: Setiap laporan keuangan yang disusun untuk klien wajib diekspor ke format **CSV** dan **PDF** secara otomatis (menggunakan script `export_financial_report.ps1`) dan ditempatkan di `[Tahun]/05_Laporan_Final/02_Laporan_Keuangan_Tahunan/` (atau `01_Laporan_Keuangan_Bulanan/`) dengan tautan dokumen langsung (`file://...`) yang dapat dibuka klien.

---

## 3. Tiga Mode Operasional Penanganan Klien

```
[1. Profiling & Onboarding Klien] 
      ↓
[2. Tax Advisory Memo (Client-Facing)]
      ↓
[3. Pendampingan SP2DK & Hearing Support]
```

### Mode 1: Profiling & Diagnostic Klien Baru
Gunakan mode ini ketika pertama kali menangani klien baru untuk memetakan seluruh kewajiban dan fasilitas perpajakan.

**Struktur Output Profiling:**
1. **Lembar Data Master Klien**:
   - Nama Entitas & Bentuk Usaha (PT / CV / WPOP / Firma / Koperasi).
   - NPWP 16 Digit / NIK / NITKU Cabang.
   - Klasifikasi Lapangan Usaha (KLU) & Karakteristik Industri.
   - Status Pengukuhan PKP (PKP vs Non-PKP) dan Peredaran Bruto Tahunan.
   - Metode Pencatatan (Pembukuan Akrual / Pencatatan NPPN / PP 55).
2. **Matriks Kewajiban Pajak Klien**:
   - Kewajiban Masa (PPh 21, PPh 23, PPh 4(2), PPh 25, PPN).
   - Kewajiban Tahunan (SPT Tahunan 1771 / 1770).
3. **Fasilitas Pajak yang Berhak Didapat**:
   - Evaluasi fasilitas Pasal 31E UU PPh (diskon tarif 50%).
   - Evaluasi ambang batas bebas pajak Rp 500 juta (WPOP PP 55).
   - Pemanfaatan natura non-objek PMK 66/2023.

---

### Mode 2: Tax Advisory Memo (Memorandum Resmi untuk Klien)
Gunakan mode ini untuk mengonversi hasil komputasi teknis (dari `/ama-badan`, `/ama-pph21`, atau `/ama-simulasi`) menjadi dokumen rekomendasi resmi yang siap diserahkan kepada Direksi / Pemilik Usaha.

**Format Standar Tax Advisory Memo:**
```markdown
# MEMORANDUM KONSULTASI PERPAJAKAN
**Nomor**: [No. Ref Memo]  
**Kepada**: Direksi / Manajemen [Nama Perusahaan Klien]  
**Dari**: Tim Konsultan Pajak AMA  
**Tanggal**: [Tanggal]  
**Perihal**: [Topik, misal: Rekomendasi Efisiensi PPh Badan & Mitigasi Risiko 2026]

---

### I. Ringkasan Eksekutif (Bottom-Line Summary)
Ringkasan singkat 2-3 paragraf mengenai inti masalah, dampak finansial ke perusahaan, dan rekomendasi utama tanpa istilah rumit.

### II. Pembahasan Fakta & Analisis Risiko
- Uraian transaksi atau kondisi pembukuan klien saat ini.
- Analisis peraturan perpajakan terkait dan risiko sanksi jika tidak disesuaikan.

### III. Rekomendasi Solusi & Action Plan Tim Finance
Langkah konkret yang harus dieksekusi tim keuangan klien:
1. Penyesuaian kontrak atau dokumen pendukung (Invoice/Faktur).
2. Prosedur pembuatan bukti potong atau pengkreditan faktur pajak.
3. Estimasi penghematan pajak legal (*tax savings*).

### IV. Checklist Dokumen yang Perlu Disiapkan Klien
Daftar berkas yang harus diserahkan klien kepada konsultan/KPP minggu ini.
```

---

### Mode 3: Pendampingan SP2DK & Hearing Support
Gunakan mode ini ketika klien menerima Surat Permintaan Penjelasan atas Data dan/atau Keterangan (SP2DK) dari KPP.

**Panduan Pendampingan:**
1. **Analisis Data Pemicu AR (Account Representative)**:
   - Identifikasi pemicu selisih (misal: selisih omzet SPT Badan vs PPN, transaksi lawan risiko tinggi).
2. **Strategi Respons**:
   - *Jalur Klarifikasi Penuh*: Jika data klien benar dan dapat dibuktikan dengan Buku Besar, rekening koran, atau dokumen pendukung.
   - *Jalur Pembetulan Mandiri*: Jika memang terdapat kekeliruan administrasi (menghindari pemeriksaan formal).
3. **Poin Bicara Konsultan (*Talking Points for Hearing*)**:
   - Poin-poin diplomatis yang harus disampaikan saat mendampingi klien berbicara langsung dengan AR KPP.
4. **Draft Surat Tanggapan Resmi Klien ke KPP**:
   - Surat resmi bertandatangan direktur klien dengan lampiran daftar bukti rekonsiliasi.

---

## 4. Aturan Wajib Keterkaitan Lintas Pajak & Deteksi Denda
> [!CAUTION]
> **PEMBERITAHUAN RESMI KE KLIEN**
> Dalam setiap memo atau arahan kepada klien, AMA **WAJIB** mencantumkan:
> 1. Peringatan dini jika transaksi klien memicu keterkaitan ke jenis pajak lain (*Cross-Tax Alert*).
> 2. Peringatan denda keterlambatan setor/lapor (Pasal 7 & Pasal 9 UU KUP) agar tim finance klien disiplin terhadap *tax calendar*.

---

## 5. Integrasi dengan Modul AMA Lainnya
- Ambil hasil proyeksi dari **`/ama-simulasi`** untuk menyusun proposal *Financial & Tax Health Check*.
- Ambil hasil rekonsiliasi dari **`/ama-badan`** untuk diubah menjadi *Executive Tax Memo*.
- Ambil temuan ekualisasi dari **`/ama-review`** untuk menyusun materi jawaban SP2DK klien.
- Gunakan skrip pendukung: [scripts/init_client_structure.ps1](scripts/init_client_structure.ps1)

