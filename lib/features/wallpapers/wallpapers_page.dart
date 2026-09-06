import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

class WallpapersPage extends StatelessWidget {
  const WallpapersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpapers = <String>[
      'assets/wallpapers/wallpaper_01.png',
      'assets/wallpapers/wallpaper_02.png',
      'assets/wallpapers/wallpaper_03.png',
      'assets/wallpapers/wallpaper_04.png',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تميّز بخلفية شاشة'),
          backgroundColor: AppColors.deep2,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .58,
          ),
          itemCount: wallpapers.length,
          itemBuilder: (_, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Material(
                color: AppColors.deep2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _WallpaperPreview(
                          asset: wallpapers[index],
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    wallpapers[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WallpaperPreview extends StatelessWidget {
  final String asset;

  const _WallpaperPreview({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('معاينة الخلفية'),
          backgroundColor: AppColors.deep2,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(asset, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('سنربط التحميل المباشر من Google Drive في الخطوة التالية.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('حفظ الخلفية'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}