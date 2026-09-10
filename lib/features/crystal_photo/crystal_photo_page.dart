import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heic_to_png_jpg/heic_to_png_jpg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;

import '../../app/theme/app_theme.dart';

class CrystalPhotoPage extends StatefulWidget {
  const CrystalPhotoPage({super.key});

  @override
  State<CrystalPhotoPage> createState() => _CrystalPhotoPageState();
}

class _CrystalPhotoPageState extends State<CrystalPhotoPage> {
  // ============================================================
  // IMAGE PICKER
  // ============================================================

  final ImagePicker _picker = ImagePicker();

  // ============================================================
  // IMAGES
  // ============================================================

  Uint8List? _originalBytes;
  Uint8List? _resultBytes;

  // ============================================================
  // STATES
  // ============================================================

  bool _generating = false;
  bool _converting = false;

  // ============================================================
  // SELECTED STYLE
  // ============================================================

  String _selectedStyle = 'فاخرة';

  final List<String> _styles = [
    'خفيفة',
    'فاخرة',
    'وطنية',
    'كاملة',
  ];

  // ============================================================
  // IMAGE SIZE
  // نفس مقاس صورة Cover Flow في صفحة التهنئة
  // ============================================================

  static const double _imageWidth = 230;
  static const double _imageHeight = 405;

  // ============================================================
  // VERCEL API
  // ============================================================

  static const String _crystalApi =
      'https://azna-btabana-96-flutter-web.vercel.app/api/crystal';

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<void> _pickImage() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxWidth: 1600,
        maxHeight: 1600,
      );

      if (file == null) return;

      if (!mounted) return;

      setState(() {
        _converting = true;
        _resultBytes = null;
      });

      final bytes = await file.readAsBytes();

      Uint8List finalBytes;

      // ==========================================================
      // HEIC / HEIF
      // ==========================================================

      if (HeicConverter.isHeic(bytes)) {
        _showMessage(
          'نجهز صورة الآيفون لك... 💎',
        );

        finalBytes = await HeicConverter.convertToPNG(
          heicData: bytes,
          maxWidth: 1600,
          maxHeight: 1600,
        );
      } else {
        finalBytes = bytes;
      }

      if (!mounted) return;

      setState(() {
        _originalBytes = finalBytes;
        _resultBytes = null;
        _converting = false;
      });

      _showMessage(
        'تم رفع الصورة وتجهيزها بنجاح ✨',
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _converting = false;
      });

      _showMessage(
        'تعذر تجهيز الصورة، جرّب صورة أخرى',
      );
    }
  }

  // ============================================================
  // CRYSTALIZE
  // ============================================================

  Future<void> _generateCrystal() async {
    if (_originalBytes == null) {
      _showMessage(
        'ارفع صورتك أولاً 💎',
      );
      return;
    }

    if (_converting) {
      _showMessage(
        'انتظر حتى تجهز الصورة ✨',
      );
      return;
    }

    setState(() {
      _generating = true;
      _resultBytes = null;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(_crystalApi),
      );

      // ==========================================================
      // STYLE
      // ==========================================================

      request.fields['style'] = _selectedStyle;

      // ==========================================================
      // IMAGE
      // ==========================================================

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          _originalBytes!,
          filename: 'user_photo.png',
          contentType: http.MediaType(
            'image',
            'png',
          ),
        ),
      );

      // ==========================================================
      // SEND
      // ==========================================================

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(
        streamedResponse,
      );

      // ==========================================================
      // ERROR
      // ==========================================================

      if (response.statusCode != 200) {
        String message = 'حدث خطأ أثناء الفصفصة';

        try {
          final data = jsonDecode(
            response.body,
          );

          if (data['error'] != null) {
            message = data['error'].toString();
          }
        } catch (_) {}

        throw Exception(message);
      }

      // ==========================================================
      // RESPONSE
      // ==========================================================

      final data = jsonDecode(
        response.body,
      );

      if (data['image'] == null) {
        throw Exception(
          'لم يتم استلام الصورة الناتجة',
        );
      }

      final result = base64Decode(
        data['image'],
      );

      if (!mounted) return;

      setState(() {
        _resultBytes = result;
      });

      _showMessage(
        'تمت الفصفصة بنجاح ✨',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _generating = false;
      });
    }
  }

  // ============================================================
  // DOWNLOAD RESULT
  // ============================================================

  void _downloadImage() {
    if (_resultBytes == null) return;

    final blob = html.Blob(
      [_resultBytes!],
      'image/png',
    );

    final url = html.Url.createObjectUrlFromBlob(
      blob,
    );

    final anchor = html.AnchorElement(
      href: url,
    )
      ..download = 'azna-btabana-96.png'
      ..style.display = 'none';

    html.document.body?.children.add(anchor);

    anchor.click();

    anchor.remove();

    html.Url.revokeObjectUrl(url);
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'SaudiWeb',
            ),
          ),
        ),
      );
  }

  // ============================================================
  // CURRENT IMAGE
  //
  // إذا فيه نتيجة نعرضها
  // وإلا نعرض الصورة الأصلية
  // ============================================================

  Uint8List? get _currentImage {
    if (_resultBytes != null) {
      return _resultBytes;
    }

    return _originalBytes;
  }

  // ============================================================
  // IMAGE CARD
  //
  // الصورة تظهر مرة واحدة فقط
  // وبنفس مقاس صورة Cover Flow
  // ============================================================

  Widget _imageCard() {
    final image = _currentImage;

    if (image == null) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Container(
        width: _imageWidth,
        height: _imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _resultBytes != null
                ? AppColors.gold
                : AppColors.muted.withOpacity(0.25),
            width: _resultBytes != null ? 2 : 1,
          ),
          boxShadow: _resultBytes != null
              ? [
                  BoxShadow(
                    color: AppColors.gold.withOpacity(0.22),
                    blurRadius: 22,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ==================================================
            // IMAGE
            // ==================================================

            Image.memory(
              image,
              width: _imageWidth,
              height: _imageHeight,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              gaplessPlayback: true,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return _imageError();
              },
            ),

            // ==================================================
            // GENERATING OVERLAY
            // ==================================================

            if (_generating)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.58),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 34,
                        height: 34,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.gold,
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'نجهز الفصفصة لك... ✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SaudiWeb',
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
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
            Icons.broken_image_outlined,
            color: AppColors.muted,
            size: 42,
          ),
          SizedBox(height: 10),
          Text(
            'تعذر تحميل الصورة',
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
  // UPLOAD BOX
  // يظهر فقط قبل اختيار الصورة
  // ============================================================

  Widget _uploadBox() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 60,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.gold.withOpacity(0.45),
            width: 1.5,
          ),
          color: AppColors.deep2.withOpacity(0.55),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '💎',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'ارفع صورتك',
              style: TextStyle(
                fontFamily: 'SaudiWeb',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'اختر صورة من جهازك',
              style: TextStyle(
                fontFamily: 'SaudiWeb',
                color: AppColors.muted,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE ACTIONS
  //
  // بعد ظهور الصورة:
  // تغيير الصورة + حفظ النتيجة
  // ============================================================

  Widget _imageActions() {
    if (_originalBytes == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // ==================================================
        // STATUS
        // ==================================================

        if (_resultBytes != null)
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.emeraldBright,
                size: 19,
              ),
              SizedBox(width: 6),
              Text(
                'تمت الفصفصة بنجاح',
                style: TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.emeraldBright,
                size: 19,
              ),
              SizedBox(width: 6),
              Text(
                'تم رفع الصورة',
                style: TextStyle(
                  fontFamily: 'SaudiWeb',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

        const SizedBox(height: 10),

        // ==================================================
        // CHANGE IMAGE
        // ==================================================

        TextButton.icon(
          onPressed: _converting || _generating ? null : _pickImage,
          icon: const Icon(
            Icons.refresh_rounded,
            size: 19,
          ),
          label: const Text(
            'تغيير الصورة',
            style: TextStyle(
              fontFamily: 'SaudiWeb',
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STYLE SECTION
  // ============================================================

  Widget _styleSection() {
    if (_originalBytes == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'اختر مستوى الفصفصة',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'SaudiWeb',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _styles.map(
            (style) {
              final bool selected = _selectedStyle == style;

              return ChoiceChip(
                label: Text(
                  style,
                  style: const TextStyle(
                    fontFamily: 'SaudiWeb',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                selected: selected,
                onSelected: _converting || _generating
                    ? null
                    : (_) {
                        setState(() {
                          _selectedStyle = style;

                          // إذا تغير المستوى
                          // نخفي النتيجة القديمة
                          _resultBytes = null;
                        });
                      },
                selectedColor: AppColors.gold,
                backgroundColor: AppColors.deep2,
                labelStyle: TextStyle(
                  fontFamily: 'SaudiWeb',
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.deep : AppColors.white,
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  // ============================================================
  // GENERATE BUTTON
  // ============================================================

  Widget _generateButton() {
    if (_originalBytes == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 56,
      child: ElevatedButton.icon(
        onPressed: (_generating || _converting) ? null : _generateCrystal,
        icon: _generating
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                '💎',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
        label: Text(
          _generating
              ? 'جاري الفصفصة...'
              : _resultBytes != null
                  ? 'إعادة الفصفصة'
                  : 'فصفص صورتي',
          style: const TextStyle(
            fontFamily: 'SaudiWeb',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DOWNLOAD BUTTON
  // ============================================================

  Widget _downloadButton() {
    if (_resultBytes == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 54,
      child: OutlinedButton.icon(
        onPressed: _downloadImage,
        icon: const Icon(
          Icons.download_rounded,
        ),
        label: const Text(
          'حفظ الصورة',
          style: TextStyle(
            fontFamily: 'SaudiWeb',
            fontSize: 16,
            fontWeight: FontWeight.bold,
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          '💎 فصفص صورتك',
          style: TextStyle(
            fontFamily: 'SaudiWeb',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.deep2,
        foregroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            tooltip: 'رجوع',
          ),
        ],
      ),
      backgroundColor: AppColors.deep,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =================================================
                // TITLE
                // =================================================

                const Text(
                  'حوّل صورتك إلى إطلالة وطنية من الفصفصة ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SaudiWeb',
                    fontSize: 15,
                    color: AppColors.muted,
                  ),
                ),

                const SizedBox(height: 24),

                // =================================================
                // الصورة تظهر هنا مرة واحدة فقط
                //
                // قبل الرفع:
                // Upload Box
                //
                // بعد الرفع:
                // الصورة
                //
                // بعد النتيجة:
                // نفس المكان = الصورة الناتجة
                // =================================================

                if (_originalBytes == null) _uploadBox() else _imageCard(),

                // =================================================
                // CONVERTING
                // =================================================

                if (_converting) ...[
                  const SizedBox(height: 16),
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.gold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'نجهز الصورة لك... ✨',
                          style: TextStyle(
                            fontFamily: 'SaudiWeb',
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // =================================================
                // AFTER IMAGE
                // =================================================

                if (_originalBytes != null) ...[
                  const SizedBox(height: 10),

                  _imageActions(),

                  const SizedBox(height: 24),

                  // =================================================
                  // STYLES
                  // =================================================

                  _styleSection(),

                  const SizedBox(height: 24),

                  // =================================================
                  // GENERATE
                  // =================================================

                  _generateButton(),

                  // =================================================
                  // DOWNLOAD
                  // =================================================

                  if (_resultBytes != null) ...[
                    const SizedBox(height: 12),
                    _downloadButton(),
                  ],
                ],

                const SizedBox(height: 20),

                // =================================================
                // FOOTER
                // =================================================

                const Text(
                  'عزنا بطبعنا 🇸🇦',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SaudiWeb',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
