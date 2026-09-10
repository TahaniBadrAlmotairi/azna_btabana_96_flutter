import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class CrystalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  const CrystalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 82,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),

                // زجاج كريستالي
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white.withOpacity(.20),
                    AppColors.deep2.withOpacity(.48),
                  ],
                ),

                border: Border.all(
                  color: Colors.white.withOpacity(.35),
                  width: 1,
                ),

                boxShadow: [
                  BoxShadow(
                    color: accent.withOpacity(.22),
                    blurRadius: 24,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  // ========================================================
                  // ICON
                  // ========================================================

                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          accent.withOpacity(.90),
                          accent.withOpacity(.25),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(.45),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(.30),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 13),

                  // ========================================================
                  // TEXT
                  // ========================================================

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontFamily: 'SaudiWeb',
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'SaudiWeb',
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // ========================================================
                  // ARROW
                  // ========================================================

                  const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 17,
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
