import 'package:flutter/material.dart';
import 'package:gestuaca/screens/auth/login_page.dart';
import 'package:gestuaca/screens/auth/signup_page.dart';
import 'package:gestuaca/screens/home_page.dart';
import 'package:gestuaca/screens/panels/directeur/dashboard.dart';
import 'onboarding/onboard_layout.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: OnboardLayout(),
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomePage(),
        '/auth/signup': (context) => const SignupPage(),
        '/auth/login': (context) => const LoginPage(),
        '/panels/directeur/dashboard': (context) => const DashboardPage()
      },
    );
  }
}




