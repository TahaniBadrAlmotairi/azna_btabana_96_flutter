import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../app/theme/app_theme.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  final _name = TextEditingController();
  final _key = GlobalKey();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<Uint8List?> _capture() async {
    final boundary = _key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;
    final image = await boundary.toImage(pixelRatio: 3);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data?.buffer.asUint8List();
  }

  Future<void> _save() async {
    final bytes = await _capture();
    if (bytes == null) return;

    // TODO(web): connect this byte array to a browser download helper.
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('المعاينة جاهزة. سنوصل زر التحميل للويب في الخطوة التالية.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('صمّم تهنئتك'),
          backgroundColor: AppColors.deep2,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            RepaintBoundary(
              key: _key,
              child: AspectRatio(
                aspectRatio: .72,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF0B4B43),
                        Color(0xFF062A2D),
                      ],
                    ),
                    border: Border.all(color: AppColors.emerald),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/identity/logo.png',
                        width: 170,
                      ),
                      const SizedBox(height: 38),
                      const Text(
                        'كل عام ووطننا بخير',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _name.text.trim().isEmpty ? 'اسمك هنا' : _name.text.trim(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: AppColors.emeraldBright,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'عزنا بطبعنا',
                        style: TextStyle(
                          fontSize: 19,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'اليوم الوطني السعودي 96',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: _name,
              onChanged: (_) => setState(() {}),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'اكتب اسمك',
                hintText: 'مثال: تهاني',
                prefixIcon: const Icon(Icons.person_outline),
                filled: true,
                fillColor: AppColors.deep2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.download_rounded),
              label: const Text('حفظ التهنئة'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}