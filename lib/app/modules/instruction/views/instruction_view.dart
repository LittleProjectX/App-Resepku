import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';
import 'package:seleraku/app/core/widgets/buttons/button_back.dart';

import '../controllers/instruction_controller.dart';

class InstructionView extends GetView<InstructionController> {
  const InstructionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              children: [
                buttonCircle(
                  onTap: () => Get.back(),
                  icon: Icons.arrow_back,
                  left: 24,
                ),
                const SizedBox(width: 12),
                Text('Panduan Penggunaan', style: AppTextStyle.heading5),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.surface,
              ),
              child: Text('''Panduan Penggunaan SELERAKU

1. Melihat Resep
• Buka halaman Beranda.
• Jelajahi resep yang tersedia atau gunakan kolom pencarian untuk mencari resep berdasarkan judul.
• Pilih resep yang diinginkan untuk melihat informasi lengkap, seperti bahan, langkah pembuatan, dan detail lainnya.

2. Membuat Resep Baru
• Buka menu Pribadi.
• Tekan tombol Tambah Resep.
• Isi seluruh informasi resep, seperti judul, kategori, deskripsi, bahan, langkah pembuatan, dan gambar.
• Setelah semua data terisi dengan benar, tekan tombol Simpan untuk mempublikasikan resep.

3. Mengubah Profil dan Password
• Masuk ke menu Profil.
• Pilih Ubah Profil untuk memperbarui informasi akun, seperti nama atau foto profil.
• Pilih Ganti Password untuk mengubah kata sandi akun Anda, kemudian ikuti petunjuk yang tersedia.

Selamat menggunakan SELERAKU! Temukan berbagai inspirasi masakan dan bagikan resep terbaik Anda kepada pengguna lainnya.
''', style: AppTextStyle.body3),
            ),
          ],
        ),
      ),
    );
  }
}
