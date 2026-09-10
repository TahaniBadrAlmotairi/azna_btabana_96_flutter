import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import '../../app/theme/app_theme.dart';

class WallpapersPage extends StatefulWidget {
  const WallpapersPage({super.key});

  @override
  State<WallpapersPage> createState() => _WallpapersPageState();
}

class _WallpapersPageState extends State<WallpapersPage> {
  // ============================================================
  // VERCEL DRIVE PROXY
  // ============================================================

  static const String _driveProxy =
      'https://azna-btabana-96-flutter-web.vercel.app/api/drive-image';

  // ============================================================
  // ORIGINAL WALLPAPER SIZE
  // 941 × 1672
  // ============================================================

  static const double _wallpaperWidth = 941;
  static const double _wallpaperHeight = 1672;

  static const double _aspectRatio = _wallpaperWidth / _wallpaperHeight;

  // ============================================================
  // SAME CARD SIZE AS GREETING PAGE
  // ============================================================

  static const double _cardWidth = 230;
  static const double _cardHeight = 405;

  // ============================================================
  // STATE
  // ============================================================

  int _selectedIndex = 0;

  final Map<int, Uint8List> _loadedImages = {};

  final Set<int> _loadingImages = {};

  late final PageController _pageController;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.62,
    );

    // تحميل أول خلفيتين مباشرة
    _loadWallpaper(0);
    _loadWallpaper(1);
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ============================================================
  // WALLPAPER ONE
  // ============================================================

  Widget _wallpaperOne() {
    return _wallpaperCard(
      index: 0,
      driveId: '1dxOwKOt1-eemLF5QNIg4BGLHjWmjzNkA',
    );
  }

  // ============================================================
  // WALLPAPER TWO
  // ============================================================

  Widget _wallpaperTwo() {
    return _wallpaperCard(
      index: 1,
      driveId: '1h42LrUDZSSk3FVkiU18gOBK4bcnjPds9',
    );
  }

  // ============================================================
  // WALLPAPER THREE
  // ============================================================

  Widget _wallpaperThree() {
    return _wallpaperCard(
      index: 2,
      driveId: '1qQohWbkOAoVTWAR5uqiqD9eUqlFmvZ5V',
    );
  }

  // ============================================================
  // WALLPAPER FOUR
  // ============================================================

  Widget _wallpaperFour() {
    return _wallpaperCard(
      index: 3,
      driveId: '1WB-1BsoM3-g0-8IoLtUabC2ikjzGNwPP',
    );
  }

  // ============================================================
  // WALLPAPER FIVE
  // ============================================================

  Widget _wallpaperFive() {
    return _wallpaperCard(
      index: 4,
      driveId: '1uhosSFdMowwSRFl6bBFjQqNywsTtAlK4',
    );
  }

  // ============================================================
  // WALLPAPER SIX
  // ============================================================

  Widget _wallpaperSix() {
    return _wallpaperCard(
      index: 5,
      driveId: '1a6K45zHYQk2dtEJMxsQWkOH9UKdz_irp',
    );
  }

  // ============================================================
  // WALLPAPER SEVEN
  // ============================================================

  Widget _wallpaperSeven() {
    return _wallpaperCard(
      index: 6,
      driveId: '1tY5W9pGcNikEmhYjAx0-CMrA7bIgWfVE',
    );
  }

  // ============================================================
  // WALLPAPER EIGHT
  // ============================================================

  Widget _wallpaperEight() {
    return _wallpaperCard(
      index: 7,
      driveId: '1gavOq6PubByiMWaowDgaJ8uMAY8QlG0z',
    );
  }

  // ============================================================
  // WALLPAPER NINE
  // ============================================================

  Widget _wallpaperNine() {
    return _wallpaperCard(
      index: 8,
      driveId: '126fe2hLUEp0tHPck6VNq4M7p1gGU4DJ9',
    );
  }

  // ============================================================
  // WALLPAPER TEN
  // ============================================================

  Widget _wallpaperTen() {
    return _wallpaperCard(
      index: 9,
      driveId: '17-0FPl5vK7alZFrM8x9AJTgGCtQG7adS',
    );
  }

  // ============================================================
  // WALLPAPER ELEVEN
  // ============================================================

  Widget _wallpaperEleven() {
    return _wallpaperCard(
      index: 10,
      driveId: '1hOz26FJ64hgcugwjNWgHcFzyKC0T6SZm',
    );
  }

  // ============================================================
  // WALLPAPER TWELVE
  // ============================================================

  Widget _wallpaperTwelve() {
    return _wallpaperCard(
      index: 11,
      driveId: '1hrSQVV5BK7lUJ_jlkSTW8fvh0i-MVT1R',
    );
  }

  // ============================================================
  // GET WALLPAPER
  // ============================================================

  Widget _getWallpaper(int index) {
    switch (index) {
      case 0:
        return _wallpaperOne();

      case 1:
        return _wallpaperTwo();

      case 2:
        return _wallpaperThree();

      case 3:
        return _wallpaperFour();

      case 4:
        return _wallpaperFive();

      case 5:
        return _wallpaperSix();

      case 6:
        return _wallpaperSeven();

      case 7:
        return _wallpaperEight();

      case 8:
        return _wallpaperNine();

      case 9:
        return _wallpaperTen();

      case 10:
        return _wallpaperEleven();

      case 11:
        return _wallpaperTwelve();

      default:
        return _wallpaperOne();
    }
  }

  // ============================================================
  // GET DRIVE ID
  // ============================================================

  String _getDriveId(int index) {
    switch (index) {
      case 0:
        return '1dxOwKOt1-eemLF5QNIg4BGLHjWmjzNkA';

      case 1:
        return '1h42LrUDZSSk3FVkiU18gOBK4bcnjPds9';

      case 2:
        return '1qQohWbkOAoVTWAR5uqiqD9eUqlFmvZ5V';

      case 3:
        return '1WB-1BsoM3-g0-8IoLtUabC2ikjzGNwPP';

      case 4:
        return '1uhosSFdMowwSRFl6bBFjQqNywsTtAlK4';

      case 5:
        return '1a6K45zHYQk2dtEJMxsQWkOH9UKdz_irp';

      case 6:
        return '1tY5W9pGcNikEmhYjAx0-CMrA7bIgWfVE';

      case 7:
        return '1gavOq6PubByiMWaowDgaJ8uMAY8QlG0z';

      case 8:
        return '126fe2hLUEp0tHPck6VNq4M7p1gGU4DJ9';

      case 9:
        return '17-0FPl5vK7alZFrM8x9AJTgGCtQG7adS';

      case 10:
        return '1hOz26FJ64hgcugwjNWgHcFzyKC0T6SZm';

      case 11:
        return '1hrSQVV5BK7lUJ_jlkSTW8fvh0i-MVT1R';

      default:
        return '';
    }
  }

  // ============================================================
  // LOAD WALLPAPER
  // ============================================================

  Future<void> _loadWallpaper(int index) async {
    if (_loadedImages.containsKey(index)) {
      return;
    }

    if (_loadingImages.contains(index)) {
      return;
    }

    _loadingImages.add(index);

    if (mounted) {
      setState(() {});
    }

    try {
      final driveId = _getDriveId(index);

      final response = await http.get(
        Uri.parse(
          '$_driveProxy?id=$driveId',
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load wallpaper: '
          '${response.statusCode}',
        );
      }

      final data = jsonDecode(
        response.body,
      );

      if (data['success'] != true) {
        throw Exception(
          'Image loading failed',
        );
      }

      final String base64Image = data['image'];

      final Uint8List bytes = base64Decode(base64Image);

      _loadedImages[index] = bytes;
    } catch (e) {
      debugPrint(
        'Wallpaper $index error: $e',
      );
    } finally {
      _loadingImages.remove(index);

      if (mounted) {
        setState(() {});
      }
    }
  }

  // ============================================================
  // WALLPAPER CARD
  // نفس نمط صفحة التهنئة
  // ============================================================

  Widget _wallpaperCard({
    required int index,
    required String driveId,
  }) {
    final bytes = _loadedImages[index];

    final isLoading = _loadingImages.contains(index);

    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            index,
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeOutCubic,
          );
        }
      },
      child: Container(
        width: _cardWidth,
        height: _cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.gold : Colors.transparent,
            width: isSelected ? 2.5 : 0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(
                      0.25,
                    ),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Container(
            color: AppColors.deep2,
            child: bytes != null
                ? Image.memory(
                    bytes,

                    width: _cardWidth,
                    height: _cardHeight,

                    // مهم:
                    // لا نقص الخلفية
                    fit: BoxFit.contain,

                    alignment: Alignment.center,

                    filterQuality: FilterQuality.high,

                    gaplessPlayback: true,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return _imageError();
                    },
                  )
                : isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.gold,
                          strokeWidth: 2.5,
                        ),
                      )
                    : _imageError(),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE ERROR
  // ============================================================

  Widget _imageError() {
    return Container(
      color: AppColors.deep2,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            color: AppColors.muted,
            size: 42,
          ),
          SizedBox(height: 10),
          Text(
            'تعذر تحميل الخلفية',
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
  // SAVE WALLPAPER
  // ============================================================

  void _saveWallpaper(int index) {
    final bytes = _loadedImages[index];

    if (bytes == null) {
      return;
    }

    final blob = html.Blob(
      [bytes],
      'image/png',
    );

    final url = html.Url.createObjectUrlFromBlob(
      blob,
    );

    final anchor = html.AnchorElement(
      href: url,
    )
      ..setAttribute(
        'download',
        'azna_btabana_wallpaper_${index + 1}.png',
      )
      ..style.display = 'none';

    html.document.body?.children.add(anchor);

    anchor.click();

    anchor.remove();

    html.Url.revokeObjectUrl(url);

    _showMessage(
      'تم حفظ الخلفية بنجاح ✨',
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message,
  ) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
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
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.deep,

        // ========================================================
        // APP BAR
        // ========================================================

        appBar: AppBar(
          title: const Text(
            'تميّز بخلفية شاشة',
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
        // BODY
        // ========================================================

        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(
              top: 18,
              bottom: 30,
            ),
            children: [
              // ==================================================
              // TITLE
              // ==================================================

              const Text(
                'اختر خلفيتك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              const Text(
                'اسحب يمين ويسار واختر الخلفية اللي تعجبك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.muted,
                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // COVER FLOW
              // ==================================================

              SizedBox(
                height: 500,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 12,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });

                    // تحميل الحالية
                    _loadWallpaper(index);

                    // تحميل اللي بعدها
                    if (index + 1 < 12) {
                      _loadWallpaper(
                        index + 1,
                      );
                    }

                    // تحميل اللي قبلها
                    if (index - 1 >= 0) {
                      _loadWallpaper(
                        index - 1,
                      );
                    }
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

                        final difference = page - index;

                        final distance = difference.abs();

                        // ==========================================
                        // SCALE
                        // ==========================================

                        final scale = (1 - distance * 0.22).clamp(
                          0.72,
                          1.0,
                        );

                        // ==========================================
                        // ROTATION
                        // ==========================================

                        final rotation = difference.clamp(
                              -1.0,
                              1.0,
                            ) *
                            0.10;

                        // ==========================================
                        // OPACITY
                        // ==========================================

                        final opacity = (1 - distance * 0.28).clamp(
                          0.55,
                          1.0,
                        );

                        return Center(
                          child: Opacity(
                            opacity: opacity,
                            child: Transform.rotate(
                              angle: rotation,
                              child: Transform.scale(
                                scale: scale,
                                child: _getWallpaper(
                                  index,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // ==================================================
              // INDICATOR
              // نفس صفحة التهنئة
              // ==================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.swipe_rounded,
                    color: AppColors.gold,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    '${_selectedIndex + 1} من 12',
                    style: const TextStyle(
                      fontFamily: 'SaudiWeb',
                      color: AppColors.muted,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              // ==================================================
              // SAVE BUTTON
              // ==================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: FilledButton.icon(
                  onPressed: _loadedImages[_selectedIndex] == null
                      ? null
                      : () {
                          _saveWallpaper(
                            _selectedIndex,
                          );
                        },
                  icon: const Icon(
                    Icons.download_rounded,
                  ),
                  label: const Text(
                    'حفظ الخلفية',
                    style: TextStyle(
                      fontFamily: 'SaudiWeb',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: AppColors.deep,
                    disabledBackgroundColor: AppColors.muted.withOpacity(
                      .2,
                    ),
                    disabledForegroundColor: AppColors.muted.withOpacity(
                      .5,
                    ),
                    minimumSize: const Size.fromHeight(
                      56,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // FOOTER
              // ==================================================

              const Text(
                'عزنا بطبعنا 🇸🇦',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
