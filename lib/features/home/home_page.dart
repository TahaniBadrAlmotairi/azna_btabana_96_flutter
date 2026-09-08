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
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.deep2,
                  AppColors.deep,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // =========================================================
                  // HERO
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: Image.asset(
                          'assets/identity/Hero.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.deep2,
                              alignment: Alignment.center,
                              child: const Text(
                                'تعذر تحميل صورة Hero',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =========================================================
                  // SERVICES TITLE
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          'وش تبي تسوي؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'اختر خدمتك وخلّ اليوم الوطني يلمع بطبعك',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================================================
                  // SERVICE 1
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CrystalCard(
                      title: 'فصفص صورتك',
                      subtitle: 'حوّل صورتك إلى تحفة كريستالية بطابع وطني.',
                      icon: Icons.auto_awesome,
                      accent: AppColors.gold,
                      onTap: () => _go(
                        context,
                        const CrystalPhotoPage(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // =========================================================
                  // SERVICE 2
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CrystalCard(
                      title: 'صمّم تهنئتك',
                      subtitle: 'أضف اسمك إلى تهنئة اليوم الوطني واحفظها.',
                      icon: Icons.card_giftcard_rounded,
                      accent: AppColors.emeraldBright,
                      onTap: () => _go(
                        context,
                        const GreetingPage(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // =========================================================
                  // SERVICE 3
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CrystalCard(
                      title: 'تميّز بخلفية شاشة',
                      subtitle: 'اختر خلفيتك الوطنية واحفظها على جوالك.',
                      icon: Icons.phone_android_rounded,
                      accent: AppColors.teal,
                      onTap: () => _go(
                        context,
                        const WallpapersPage(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 38),

                  // =========================================================
                  // FOOTER
                  // =========================================================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 1,
                          color: AppColors.teal,
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          '96',
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 32,
                            letterSpacing: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'عزنا .. بمستقبلنا',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'عزنا بطبعنا 🇸🇦',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
