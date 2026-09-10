import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

import '../../app/theme/app_theme.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  // ============================================================
  // NAME
  // ============================================================

  final TextEditingController _nameController = TextEditingController();

  // ============================================================
  // CAPTURE
  // ============================================================

  final GlobalKey _captureKey = GlobalKey();

  // ============================================================
  // PAGE CONTROLLER
  // ============================================================

  late final PageController _pageController;

  // ============================================================
  // STATE
  // ============================================================

  int _selectedIndex = 0;
  bool _saving = false;

  // ============================================================
  // NAME COLOR
  // ============================================================

  String _nameColor = 'white';

  // ============================================================
  // VERCEL DRIVE PROXY
  // ============================================================

  static const String _driveProxy =
      'https://azna-btabana-96-flutter-web.vercel.app/api/drive-image';

  // ============================================================
  // LOADED IMAGES
  // ============================================================

  final Map<int, Uint8List> _loadedImages = {};

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.62,
    );

    _loadAllDesigns();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOAD ALL DESIGNS
  // ============================================================

  Future<void> _loadAllDesigns() async {
    await Future.wait([
      _loadDesign(
        0,
        '1d6OAUbGM9my6kkJEfMi6tFEq2dnDjU6v',
      ),
      _loadDesign(
        1,
        '1WbzmyHfqjtJbBTmhaI16m9iticrIzy8x',
      ),
      _loadDesign(
        2,
        '12Z_HgBqUyPz7uRh8gePwVxBR4cNVRpW5',
      ),
      _loadDesign(
        3,
        '1rcs6MtfBPafqSznST6-MSRqo7TEzX0VB',
      ),
      _loadDesign(
        4,
        '1u9ZhhSzq45sK7wK0bhm7kl6jHLAtl2e5',
      ),
      _loadDesign(
        5,
        '1KAsxcjOR5AsPJoeYzQj5gut1u-JanvEe',
      ),
      _loadDesign(
        6,
        '1uodOAWETVCMDjgSseeV5_w6YTbF9TvZt',
      ),
      _loadDesign(
        7,
        '1oRB7HdhoJzQOVhQSloUxaIi6M5yIqD60',
      ),
      _loadDesign(
        8,
        '17bQO3WXslSKNj0eUDySOzXjAKqSK7ICS',
      ),
    ]);

    if (mounted) {
      setState(() {});
    }
  }

  // ============================================================
  // LOAD ONE DESIGN
  // ============================================================

  Future<void> _loadDesign(
    int index,
    String driveId,
  ) async {
    try {
      final uri = Uri.parse(
        '$_driveProxy?id=$driveId',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        debugPrint(
          'Design $index failed: ${response.statusCode}',
        );
        return;
      }

      final data = jsonDecode(response.body);

      if (data['success'] != true) {
        debugPrint(
          'Design $index API error: ${response.body}',
        );
        return;
      }

      final base64Image = data['image'] as String?;

      if (base64Image == null || base64Image.isEmpty) {
        return;
      }

      final bytes = base64Decode(base64Image);

      _loadedImages[index] = bytes;

      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      debugPrint(
        'Design $index error: $error',
      );
    }
  }

  // ============================================================
  // DESIGN ONE
  // ============================================================

  Widget _designOne() {
    return _imageFromMemory(0);
  }

  // ============================================================
  // DESIGN TWO
  // ============================================================

  Widget _designTwo() {
    return _imageFromMemory(1);
  }

  // ============================================================
  // DESIGN THREE
  // ============================================================

  Widget _designThree() {
    return _imageFromMemory(2);
  }

  // ============================================================
  // DESIGN FOUR
  // ============================================================

  Widget _designFour() {
    return _imageFromMemory(3);
  }

  // ============================================================
  // DESIGN FIVE
  // ============================================================

  Widget _designFive() {
    return _imageFromMemory(4);
  }

  // ============================================================
  // DESIGN SIX
  // ============================================================

  Widget _designSix() {
    return _imageFromMemory(5);
  }

  // ============================================================
  // DESIGN SEVEN
  // ============================================================

  Widget _designSeven() {
    return _imageFromMemory(6);
  }

  // ============================================================
  // DESIGN EIGHT
  // ============================================================

  Widget _designEight() {
    return _imageFromMemory(7);
  }

  // ============================================================
  // DESIGN NINE
  // ============================================================

  Widget _designNine() {
    return _imageFromMemory(8);
  }

  // ============================================================
  // IMAGE FROM MEMORY
  // ============================================================

  Widget _imageFromMemory(int index) {
    final bytes = _loadedImages[index];

    if (bytes == null) {
      return Container(
        color: AppColors.deep2,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.gold,
          strokeWidth: 2.5,
        ),
      );
    }

    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      filterQuality: FilterQuality.high,
      gaplessPlayback: true,
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return _imageError();
      },
    );
  }

  // ============================================================
  // GET DESIGN
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
  // DISPLAY NAME
  // ============================================================

  String get _displayName {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      return 'اسمك هنا';
    }

    return name;
  }

  // ============================================================
  // SELECTED NAME COLOR
  // ============================================================

  Color get _selectedNameColor {
    switch (_nameColor) {
      case 'black':
        return const Color(0xFF111111);

      case 'green':
        return const Color(0xFF006C35);

      case 'gold':
        return const Color(0xFFD4B56A);

      case 'white':
      default:
        return Colors.white;
    }
  }

  // ============================================================
  // NAME SHADOW
  // ============================================================

  List<Shadow> get _nameShadows {
    switch (_nameColor) {
      case 'white':
        return [
          Shadow(
            color: Colors.black.withOpacity(0.55),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ];

      case 'black':
        return [
          Shadow(
            color: Colors.white.withOpacity(0.55),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ];

      case 'green':
        return [
          Shadow(
            color: Colors.white.withOpacity(0.45),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ];

      case 'gold':
        return [
          Shadow(
            color: Colors.black.withOpacity(0.55),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ];

      default:
        return [];
    }
  }

  // ============================================================
  // COVER FLOW CARD
  // ============================================================

  Widget _buildDesignCard({
    required int index,
    required double page,
  }) {
    final difference = page - index;

    final distance = difference.abs();

    final scale = (1 - distance * 0.22).clamp(
      0.72,
      1.0,
    );

    final rotation = difference.clamp(-1.0, 1.0) * 0.10;

    final opacity = (1 - distance * 0.28).clamp(0.55, 1.0);

    final isSelected = index == _selectedIndex;

    return Center(
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: rotation,
          child: Transform.scale(
            scale: scale,
            child: RepaintBoundary(
              key: isSelected ? _captureKey : null,
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
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // ==================================================
                      // DESIGN IMAGE
                      // ==================================================

                      _getDesign(index),

                      // ==================================================
                      // NAME DIRECTLY ON IMAGE
                      // ==================================================

                      Align(
                        alignment: const Alignment(
                          0,
                          0.62,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              _displayName,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SaudiWeb',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: _selectedNameColor,
                                shadows: _nameShadows,
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
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CAPTURE SELECTED DESIGN
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
  // SAVE
  // ============================================================

  Future<void> _save() async {
    if (_saving) {
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await Future.delayed(
        const Duration(
          milliseconds: 150,
        ),
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

      html.document.body?.children.add(anchor);

      anchor.click();

      anchor.remove();

      html.Url.revokeObjectUrl(url);

      _showMessage(
        'تم حفظ التهنئة بنجاح 🇸🇦',
      );
    } catch (error) {
      debugPrint(
        'Save error: $error',
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
  // MESSAGE
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
  // COLOR CHIP
  // ============================================================

  Widget _colorChip({
    required String value,
    required String label,
    required Color color,
    required Color selectedColor,
  }) {
    final selected = _nameColor == value;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: 'SaudiWeb',
          fontWeight: FontWeight.w700,
          color: selected ? AppColors.deep : AppColors.white,
        ),
      ),
      selected: selected,
      onSelected: (_) {
        setState(() {
          _nameColor = value;
        });
      },
      avatar: CircleAvatar(
        radius: 8,
        backgroundColor: color,
      ),
      selectedColor: selectedColor,
      backgroundColor: AppColors.deep2,
      side: BorderSide(
        color: selected ? selectedColor : AppColors.muted.withOpacity(0.25),
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

              // ==================================================
              // COVER FLOW
              // ==================================================

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

              // ==================================================
              // DESIGN NUMBER
              // ==================================================

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

              // ==================================================
              // NAME FIELD
              // ==================================================

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
                    hintText: 'مثال:اخوكم/اختكم، ثم الاسم',
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

              const SizedBox(height: 14),

              // ==================================================
              // NAME COLOR
              // ==================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'لون الاسم',
                      style: TextStyle(
                        fontFamily: 'SaudiWeb',
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ==================================================
                    // FOUR COLORS
                    // ==================================================

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        // ----------------------------------------------
                        // WHITE
                        // ----------------------------------------------

                        _colorChip(
                          value: 'white',
                          label: 'أبيض',
                          color: Colors.white,
                          selectedColor: const Color(0xFFD4B56A),
                        ),

                        // ----------------------------------------------
                        // BLACK
                        // ----------------------------------------------

                        _colorChip(
                          value: 'black',
                          label: 'أسود',
                          color: const Color(0xFF111111),
                          selectedColor: const Color(0xFF006C35),
                        ),

                        // ----------------------------------------------
                        // GREEN
                        // ----------------------------------------------

                        _colorChip(
                          value: 'green',
                          label: 'أخضر',
                          color: const Color(0xFF006C35),
                          selectedColor: const Color(0xFF006C35),
                        ),

                        // ----------------------------------------------
                        // GOLD
                        // ----------------------------------------------

                        _colorChip(
                          value: 'gold',
                          label: 'ذهبي',
                          color: const Color(0xFFD4B56A),
                          selectedColor: const Color(0xFFD4B56A),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ==================================================
              // SAVE BUTTON
              // ==================================================

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
