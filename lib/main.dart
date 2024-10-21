import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TDLSApp());
}

class TDLSApp extends StatelessWidget {
  const TDLSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'TDLS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8875FF),
              brightness: Brightness.dark,
            ).copyWith(
              primary: const Color(0xFF8875FF),
              secondary: const Color(0xFF9B87FF),
            ),
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          home: const TDLSMainPage(title: 'TDLS'),
        );
      },
    );
  }
}

class TDLSMainPage extends StatefulWidget {
  const TDLSMainPage({super.key, required this.title});

  final String title;

  @override
  State<TDLSMainPage> createState() => _TDLSMainPageState();
}

class _TDLSMainPageState extends State<TDLSMainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreen(),
    );
  }
}
