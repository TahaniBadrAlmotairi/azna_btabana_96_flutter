import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../features/home/home_page.dart';

class AznaApp extends StatelessWidget {
  const AznaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'عزنا بطبعنا | اليوم الوطني السعودي 96',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomePage(),
    );
  }
}