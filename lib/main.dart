import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:client/ui/pages/login.dart';

void main() {
  runApp(const BLSApp());
}

class BLSApp extends StatelessWidget {
  const BLSApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'BLS',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 118, 143, 248)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const BLSMainPage(title: 'BLS'),
        );
      },
    );
  }
}

class BLSMainPage extends StatefulWidget {
  const BLSMainPage({super.key, required this.title});

  final String title;

  @override
  State<BLSMainPage> createState() => _BLSMainPageState();
}

class _BLSMainPageState extends State<BLSMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SecureStorage().storage.read(key: "auto_login"),
        builder: (context, snapshot) {
          return const BLSLoginPage();
        },
      ),
    );
  }
}
