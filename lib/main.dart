import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:client/ui/pages/login.dart';

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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 118, 143, 248)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
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
    return Scaffold(
      body: FutureBuilder(
        future: SecureStorage().storage.read(key: "auto_login"),
        builder: (context, snapshot) {
          return const TDLSLoginPage();
        },
      ),
    );
  }
}
