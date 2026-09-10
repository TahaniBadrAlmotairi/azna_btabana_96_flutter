import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';
import '../../core/widgets/crystal_card.dart';
import '../crystal_photo/crystal_photo_page.dart';
import '../greeting/greeting_page.dart';
import '../wallpapers/wallpapers_page.dart';

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
        backgroundColor: AppColors.deep,
        body: SafeArea(
          child: Stack(
            children: [
              // ============================================================
              // HERO - خلفية الموقع بالكامل
              // ============================================================

              Positioned.fill(
                child: Image.asset(
                  'assets/identity/Hero.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.deep,
                      alignment: Alignment.center,
                      child: const Text(
                        'تعذر تحميل صورة Hero',
                        style: TextStyle(
                          fontFamily: 'SaudiWeb',
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ============================================================
              // OVERLAY
              // ============================================================

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0.0,
                        0.35,
                        0.65,
                        1.0,
                      ],
                      colors: [
                        Colors.black.withOpacity(.08),
                        Colors.black.withOpacity(.05),
                        AppColors.deep.withOpacity(.30),
                        AppColors.deep.withOpacity(.88),
                      ],
                    ),
                  ),
                ),
              ),

              // ============================================================
              // CONTENT
              // ============================================================

              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    18,
                    18,
                    28,
                  ),
                  child: Column(
                    children: [
                      // ======================================================
                      // المساحة العلوية
                      // الشعار الموجود داخل Hero يظهر بدون إضافة شعار آخر
                      // ======================================================

                      const SizedBox(height: 30),

                      // ======================================================
                      // MAIN IDENTITY
                      // ======================================================

                      const Text(
                        'وطنية كريستالية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SaudiWeb',
                          color: Colors.white,
                          fontSize: 38,
                          height: 1.05,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 18,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'خلّ اليوم الوطني.. يلمع بطبعك 💎',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SaudiWeb',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),

                      // ======================================================
                      // مساحة كبيرة لإظهار صورة الـ Hero
                      // قبل ظهور الأزرار
                      // ======================================================

                      const SizedBox(height: 120),

                      // ======================================================
                      // SERVICE 1
                      // ======================================================

                      CrystalCard(
                        title: 'فصفص صورتك',
                        subtitle: 'حوّل صورتك إلى إطلالة كريستالية وطنية',
                        icon: Icons.auto_awesome,
                        accent: AppColors.gold,
                        onTap: () {
                          _go(
                            context,
                            const CrystalPhotoPage(),
                          );
                        },
                      ),

                      const SizedBox(height: 11),

                      // ======================================================
                      // SERVICE 2
                      // ======================================================

                      CrystalCard(
                        title: 'صمّم تهنئتك',
                        subtitle: 'أضف اسمك إلى تهنئة اليوم الوطني',
                        icon: Icons.card_giftcard_rounded,
                        accent: AppColors.emeraldBright,
                        onTap: () {
                          _go(
                            context,
                            const GreetingPage(),
                          );
                        },
                      ),

                      const SizedBox(height: 11),

                      // ======================================================
                      // SERVICE 3
                      // ======================================================

                      CrystalCard(
                        title: 'تميّز بخلفية شاشة',
                        subtitle: 'خلفيات وطنية بتفاصيل كريستالية',
                        icon: Icons.phone_android_rounded,
                        accent: AppColors.teal,
                        onTap: () {
                          _go(
                            context,
                            const WallpapersPage(),
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      // ======================================================
                      // FOOTER
                      // ======================================================

                      const Text(
                        'عزنا بطبعنا 🇸🇦',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SaudiWeb',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
