import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_registration/responsive/responsive.dart';
import 'package:vendor_registration/view/mobile/mobile_registration_screen.dart';
import 'package:vendor_registration/view/web/web_registration_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Responsive(
        mobile: MobileRegistrationScreen(),
        // tablet: HomeTab(),
        desktop: const WebRegistrationScreen(),
      ),
    );
  }
}
