import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vesti_art/ui/admin/admin_panel.View.dart';
import 'ui/common/theme/app_theme.dart';
import 'ui/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VestiArt',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: kIsWeb ? const AdminPanelView() : const HomePage(),
      // (Platform.isAndroid || Platform.isIOS)
      //     ? const HomePage()
      //     : const AdminPanelView(),
    );
  }
}
