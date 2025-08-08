import 'package:flutter/material.dart';
import 'package:gestuaca/screens/auth/constants/lib.dart';
import '../stores/states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }
  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 4)); // animation/splash delay
    final token = await Store.getToken();
    final user = await Store.getUser();

    if (mounted) {
      if (token != null && user != null) {
        Navigator.pushNamed(context, AuthConstants.redirectRole(user['role'])
            ?? '/onboardPage');
      } else {
        Navigator.pushNamed(context, '/onboardPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.black87, body: Center(child: ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset('assets/images/category/gestuacaLogo.png',height: 150,
        width:
      150,),
    )));
  }
}




