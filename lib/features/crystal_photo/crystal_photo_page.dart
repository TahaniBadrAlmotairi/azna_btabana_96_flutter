import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:heic_to_png_jpg/heic_to_png_jpg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:universal_html/html.dart' as html;

class CrystalPhotoPage extends StatefulWidget {
  const CrystalPhotoPage({super.key});

  @override
  State<CrystalPhotoPage> createState() => _CrystalPhotoPageState();
}

class _CrystalPhotoPageState extends State<CrystalPhotoPage> {
  final ImagePicker _picker = ImagePicker();

  Uint8List? _originalBytes;
  Uint8List? _resultBytes;

  bool _generating = false;
  bool _converting = false;

  String _selectedStyle = 'فاخرة';

  final List<String> _styles = [
    'خفيفة',
    'فاخرة',
    'وطنية',
    'كاملة',
  ];

  // ============================================================
  // اختيار الصورة
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

      // ----------------------------------------------------------
      // تحويل صور HEIC / HEIF الخاصة بالآيفون إلى PNG
      // ----------------------------------------------------------

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
        'تعذر تجهيز الصورة، جربي صورة أخرى',
      );
    }
  }

  // ============================================================
  // الفصفصة
  // ============================================================

  Future<void> _generateCrystal() async {
    if (_originalBytes == null) {
      _showMessage(
        'ارفعي صورتك أولاً 💎',
      );
      return;
    }

    if (_converting) {
      _showMessage(
        'انتظري حتى تجهز الصورة ✨',
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
        Uri.parse(
          'https://azna-btabana-96-flutter-btijl893a-noteam-9c23.vercel.app/api/crystal',
        ),
      );

      // ----------------------------------------------------------
      // إرسال مستوى الفصفصة
      // ----------------------------------------------------------

      request.fields['style'] = _selectedStyle;

      // ----------------------------------------------------------
      // إرسال الصورة
      // ----------------------------------------------------------

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

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(
        streamedResponse,
      );

      if (response.statusCode != 200) {
        String message = 'حدث خطأ أثناء الفصفصة';

        try {
          final data = jsonDecode(response.body);

          if (data['error'] != null) {
            message = data['error'].toString();
          }
        } catch (_) {}

        throw Exception(message);
      }

      final data = jsonDecode(response.body);

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
  // تحميل الصورة الناتجة
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
  // الرسائل
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
          ),
        ),
      );
  }

  // ============================================================
  // الصفحة
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =================================================
                // العنوان
                // =================================================

                const Text(
                  '💎 فصفص صورتك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                const Text(
                  'حوّلي صورتك إلى إطلالة وطنية من الفصفصة ✨',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                // =================================================
                // رفع الصورة / الصورة المرفوعة
                // =================================================

                if (_originalBytes == null) _uploadBox() else _uploadedImage(),

                // =================================================
                // حالة تجهيز الصورة
                // =================================================

                if (_converting) ...[
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'نجهز الصورة لك... ✨',
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ],

                // =================================================
                // خيارات الفصفصة
                // =================================================

                if (_originalBytes != null) ...[
                  const SizedBox(
                    height: 24,
                  ),

                  const Text(
                    'اختاري الفصفصة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _styles.map(
                      (style) {
                        final bool selected = _selectedStyle == style;

                        return ChoiceChip(
                          label: Text(style),
                          selected: selected,
                          onSelected: _converting
                              ? null
                              : (_) {
                                  setState(
                                    () {
                                      _selectedStyle = style;

                                      // إذا غيرت
                                      // المستوى
                                      // نخلي الناتج
                                      // القديم يختفي
                                      _resultBytes = null;
                                    },
                                  );
                                },
                        );
                      },
                    ).toList(),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // =================================================
                  // المعاينة
                  // =================================================

                  _previewCard(),

                  const SizedBox(
                    height: 20,
                  ),

                  // =================================================
                  // زر الفصفصة
                  // =================================================

                  SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: (_generating || _converting)
                          ? null
                          : _generateCrystal,
                      icon: _generating
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              '💎',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                      label: Text(
                        _generating ? 'جاري الفصفصة...' : 'فصفص صورتي',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],

                // =================================================
                // الصورة الناتجة
                // =================================================

                if (_resultBytes != null) _resultSection(),

                const SizedBox(
                  height: 40,
                ),

                const Text(
                  'عزنا بطبعنا 🇸🇦',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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

  // ============================================================
  // مربع رفع الصورة
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
            width: 2,
          ),
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
            SizedBox(
              height: 12,
            ),
            Text(
              'ارفعي صورتك',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'اختاري صورة من جهازك',
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // الصورة المرفوعة
  // ============================================================

  Widget _uploadedImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.memory(
            _originalBytes!,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 20,
            ),
            const SizedBox(
              width: 6,
            ),
            const Expanded(
              child: Text(
                'تم رفع الصورة بنجاح',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: _converting || _generating ? null : _pickImage,
              child: const Text('تغيير'),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // بطاقة المعاينة
  // ============================================================

  Widget _previewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'المعاينة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // ------------------------------------------------------
          // الصورة بدون ارتفاع محدد
          // ------------------------------------------------------

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.memory(
                  _originalBytes!,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),

                // ------------------------------------------------
                // شاشة التحميل فوق الصورة
                // ------------------------------------------------

                if (_generating)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            'نجهز الفصفصة لك... ✨',
                            style: TextStyle(
                              color: Colors.white,
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

          const SizedBox(
            height: 10,
          ),

          Text(
            'ستايل: $_selectedStyle',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // النتيجة النهائية
  // ============================================================

  Widget _resultSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 35,
        ),

        const Text(
          '✨ النتيجة',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
          height: 14,
        ),

        // --------------------------------------------------------
        // الصورة الناتجة بدون height
        // --------------------------------------------------------

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.memory(
            _resultBytes!,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(
          height: 16,
        ),

        // --------------------------------------------------------
        // حفظ الصورة
        // --------------------------------------------------------

        SizedBox(
          height: 54,
          child: OutlinedButton.icon(
            onPressed: _downloadImage,
            icon: const Icon(
              Icons.download_rounded,
            ),
            label: const Text(
              'حفظ الصورة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
