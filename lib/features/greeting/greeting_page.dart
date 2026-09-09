import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universal_html/html.dart' as html;

import '../../app/theme/app_theme.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey _captureKey = GlobalKey();

  late final PageController _pageController;

  int _selectedIndex = 0;
  bool _saving = false;

  // ============================================================
  // رابط Vercel الخاص بجلب صور Google Drive
  // ============================================================

  static const String _driveProxy =
      'https://azna-btabana-96-flutter-9y8oqkek1-noteam-9c23.vercel.app/api/drive-image';

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.62,
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // ============================================================
  // التصميم الأول
  // ============================================================

  Widget _designOne() {
    return Image.network(
      '$_driveProxy?id=1d6OAUbGM9my6kkJEfMi6tFEq2dnDjU6v',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم الثاني
  // ============================================================

  Widget _designTwo() {
    return Image.network(
      '$_driveProxy?id=1WbzmyHfqjtJbBTmhaI16m9iticrIzy8x',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم الثالث
  // ============================================================

  Widget _designThree() {
    return Image.network(
      '$_driveProxy?id=12Z_HgBqUyPz7uRh8gePwVxBR4cNVRpW5',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم الرابع
  // ============================================================

  Widget _designFour() {
    return Image.network(
      '$_driveProxy?id=1Dww_pkqEVIY-ZgzYgmRTtAU19L1mfv4b',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم الخامس
  // ============================================================

  Widget _designFive() {
    return Image.network(
      '$_driveProxy?id=1u9ZhhSzq45sK7wK0bhm7kl6jHLAtl2e5',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم السادس
  // ============================================================

  Widget _designSix() {
    return Image.network(
      '$_driveProxy?id=1KAsxcjOR5AsPJoeYzQj5gut1u-JanvEe',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم السابع
  // ============================================================

  Widget _designSeven() {
    return Image.network(
      '$_driveProxy?id=1uodOAWETVCMDjgSseeV5_w6YTbF9TvZt',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم الثامن
  // ============================================================

  Widget _designEight() {
    return Image.network(
      '$_driveProxy?id=1oRB7HdhoJzQOVhQSloUxaIi6M5yIqD60',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // التصميم التاسع
  // ============================================================

  Widget _designNine() {
    return Image.network(
      '$_driveProxy?id=17bQO3WXslSKNj0eUDySOzXjAKqSK7ICS',
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return _imageError();
      },
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        return _imageLoading(
          loadingProgress,
        );
      },
    );
  }

  // ============================================================
  // حالة تحميل الصورة
  // ============================================================

  Widget _imageLoading(
    ImageChunkEvent loadingProgress,
  ) {
    final value = loadingProgress.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
        : null;

    return Container(
      color: AppColors.deep2,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        value: value,
        color: AppColors.gold,
        strokeWidth: 2.5,
      ),
    );
  }

  // ============================================================
  // حالة الخطأ
  // ============================================================

  Widget _imageError() {
    return Container(
      color: AppColors.deep2,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: AppColors.muted,
            size: 42,
          ),
          SizedBox(height: 10),
          Text(
            'تعذر تحميل التصميم',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SaudiWeb',
              color: AppColors.muted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // اختيار التصميم
  // ============================================================

  Widget _getDesign(int index) {
    switch (index) {
      case 0:
        return _designOne();

      case 1:
        return _designTwo();

      case 2:
        return _designThree();

      case 3:
        return _designFour();

      case 4:
        return _designFive();

      case 5:
        return _designSix();

      case 6:
        return _designSeven();

      case 7:
        return _designEight();

      case 8:
        return _designNine();

      default:
        return _designOne();
    }
  }

  // ============================================================
  // الاسم
  // ============================================================

  String get _displayName {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      return 'اسمك هنا';
    }

    return name;
  }

  // ============================================================
  // كرت التصميم - Cover Flow
  // ============================================================

  Widget _buildDesignCard({
    required int index,
    required double page,
  }) {
    final difference = page - index;
    final distance = difference.abs();

    // التصميم الموجود في المنتصف يكون أكبر
    final scale = (1 - distance * 0.22).clamp(0.72, 1.0);

    // ميلان التصاميم الجانبية
    final rotation = difference.clamp(-1.0, 1.0) * 0.10;

    // شفافية بسيطة للتصاميم الجانبية
    final opacity = (1 - distance * 0.28).clamp(0.55, 1.0);

    final isSelected = index == _selectedIndex;

    return Center(
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: rotation,
          child: Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 150,
              ),
              width: 230,
              height: 405,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? AppColors.gold : Colors.transparent,
                  width: isSelected ? 2.5 : 0,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.gold.withOpacity(0.25),
                          blurRadius: 25,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: _getDesign(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // التقاط التهنئة كـ PNG
  // ============================================================

  Future<Uint8List?> _capture() async {
    final boundary = _captureKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;

    if (boundary == null) {
      return null;
    }

    final image = await boundary.toImage(
      pixelRatio: 3,
    );

    final data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );

    return data?.buffer.asUint8List();
  }

  // ============================================================
  // حفظ التهنئة
  // ============================================================

  Future<void> _save() async {
    if (_saving) {
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      // نعطي Flutter لحظة حتى يحدّث الاسم/التصميم
      await Future.delayed(
        const Duration(milliseconds: 150),
      );

      final bytes = await _capture();

      if (bytes == null) {
        _showMessage(
          'تعذر تجهيز التهنئة',
        );
        return;
      }

      final blob = html.Blob(
        [bytes],
        'image/png',
      );

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(
        href: url,
      )
        ..setAttribute(
          'download',
          'تهنئة-اليوم-الوطني-96.png',
        )
        ..style.display = 'none';

      html.document.body?.children.add(
        anchor,
      );

      anchor.click();

      anchor.remove();

      html.Url.revokeObjectUrl(url);

      _showMessage(
        'تم حفظ التهنئة بنجاح 🇸🇦',
      );
    } catch (error) {
      debugPrint(
        'Save greeting error: $error',
      );

      _showMessage(
        'تعذر حفظ التهنئة',
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  // ============================================================
  // SnackBar
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'SaudiWeb',
          ),
        ),
      ),
    );
  }

  // ============================================================
  // الصفحة
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.deep,

        // ========================================================
        // AppBar
        // ========================================================

        appBar: AppBar(
          title: const Text(
            'صمّم تهنئتك',
            style: TextStyle(
              fontFamily: 'SaudiWeb',
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: AppColors.deep2,
          foregroundColor: AppColors.white,
          elevation: 0,
        ),

        // ========================================================
        // Body
        // ========================================================

        body: ListView(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 30,
          ),
          children: [
            // ====================================================
            // العنوان
            // ====================================================

            const Text(
              'اختر تصميم تهنئتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SaudiWeb',
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'اسحب يمين ويسار واختر التصميم اللي يعجبك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SaudiWeb',
                color: AppColors.muted,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // Cover Flow
            // ====================================================

            SizedBox(
              height: 500,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 9,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                itemBuilder: (
                  context,
                  index,
                ) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (
                      context,
                      child,
                    ) {
                      double page = _selectedIndex.toDouble();

                      if (_pageController.hasClients) {
                        page =
                            _pageController.page ?? _selectedIndex.toDouble();
                      }

                      return _buildDesignCard(
                        index: index,
                        page: page,
                      );
                    },
                  );
                },
              ),
            ),

            // ====================================================
            // رقم التصميم
            // ====================================================

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.swipe_rounded,
                  color: AppColors.gold,
                  size: 18,
                ),
                const SizedBox(width: 7),
                Text(
                  '${_selectedIndex + 1} من 9',
                  style: const TextStyle(
                    fontFamily: 'SaudiWeb',
                    color: AppColors.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ====================================================
            // خانة الاسم
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: TextField(
                controller: _nameController,
                onChanged: (_) {
                  setState(() {});
                },
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.white,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  labelText: 'اكتب اسمك',
                  hintText: 'مثال: تهاني',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  filled: true,
                  fillColor: AppColors.deep2,
                  labelStyle: const TextStyle(
                    fontFamily: 'SaudiWeb',
                    color: AppColors.muted,
                  ),
                  hintStyle: const TextStyle(
                    fontFamily: 'SaudiWeb',
                    color: AppColors.muted,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: AppColors.gold,
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ====================================================
            // معاينة التهنئة النهائية
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: RepaintBoundary(
                key: _captureKey,
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // التصميم المختار
                      _getDesign(
                        _selectedIndex,
                      ),

                      // ==========================================
                      // الاسم
                      // ==========================================

                      Align(
                        alignment: const Alignment(
                          0,
                          0.62,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _displayName,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'SaudiWeb',
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 8,
                                    offset: Offset(
                                      0,
                                      2,
                                    ),
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ====================================================
            // زر الحفظ
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.download_rounded,
                      ),
                label: Text(
                  _saving ? 'جاري تجهيز التهنئة...' : 'حفظ التهنئة',
                  style: const TextStyle(
                    fontFamily: 'SaudiWeb',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.emerald,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
