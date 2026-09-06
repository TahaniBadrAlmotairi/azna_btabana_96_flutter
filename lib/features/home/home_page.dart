import 'package:flutter/material.dart';
import '../crystal_photo/crystal_photo_page.dart';
import '../greeting/greeting_page.dart';
import '../wallpapers/wallpapers_page.dart';
import '../../app/theme/app_theme.dart';
import '../../core/widgets/crystal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _go(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.deep2, AppColors.deep],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/identity/logo.png',
                      width: 190,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 26),
                  _Hero(),
                  const SizedBox(height: 28),
                  CrystalCard(
                    title: 'فصفص صورتك',
                    subtitle: 'حوّل صورتك إلى تحفة كريستالية بطابع وطني.',
                    icon: Icons.auto_awesome,
                    accent: AppColors.blue,
                    onTap: () => _go(context, const CrystalPhotoPage()),
                  ),
                  const SizedBox(height: 14),
                  CrystalCard(
                    title: 'صمّم تهنئتك',
                    subtitle: 'أضف اسمك إلى تهنئة اليوم الوطني واحفظها.',
                    icon: Icons.edit_rounded,
                    accent: AppColors.pink,
                    onTap: () => _go(context, const GreetingPage()),
                  ),
                  const SizedBox(height: 14),
                  CrystalCard(
                    title: 'تميّز بخلفية شاشة',
                    subtitle: 'اختر خلفيتك الوطنية واحفظها على جوالك.',
                    icon: Icons.phone_android_rounded,
                    accent: AppColors.emeraldBright,
                    onTap: () => _go(context, const WallpapersPage()),
                  ),
                  const SizedBox(height: 34),
                  const Text(
                    '96',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 8,
                      fontWeight: FontWeight.w700,
                      color: AppColors.muted,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'عزنا .. بمستقبلنا',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'وطنٌ يلهمنا دائمًا',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'عزنا بطبعنا',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            height: 1.05,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'اليوم الوطني السعودي 96',
          style: TextStyle(
            color: AppColors.emeraldBright,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'كل طبع له حكاية .. وكل حكاية وطن',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 17,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}