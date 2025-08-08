import 'package:flutter/material.dart';
import 'package:gestuaca/screens/auth/forgot_password.dart';
import 'package:gestuaca/screens/auth/login_page.dart';
import 'package:gestuaca/screens/auth/signup_page.dart';
import 'package:gestuaca/screens/auth/user_type_info.dart';
import 'package:gestuaca/screens/panels/teachers/teachers_layout.dart';
import 'package:gestuaca/screens/panels/directeur/directeur_layout.dart';
import 'package:gestuaca/screens/panels/students/edit_profile.dart';
import 'package:gestuaca/screens/panels/students/course_page.dart';
import 'package:gestuaca/screens/panels/students/my_account.dart';
import 'package:gestuaca/screens/panels/students/profile_page.dart';
import 'package:gestuaca/screens/panels/students/students_layout.dart';
import 'package:gestuaca/screens/panels/students/transactions_page.dart';
import 'package:gestuaca/screens/partials/notifications_page.dart';
import 'package:gestuaca/services/payment.dart';
import 'onboarding/onboard_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() async {
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
      home: const SplashScreen(),
      initialRoute: '/',
      routes: {
         '/onboardPage':(context)=> const OnboardLayout(),
        '/my_account': (context) => const MyAccount(),
        '/auth/user-type-info': (context) => const UserTypeInfoScreen(),
        '/auth/signup': (context) => const SignupPage(),
        '/payments': (context) => const PaymentStudents(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/auth/login': (context) => const LoginPage(),
        '/auth/forgot-password':(context)=> const ForgotPasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const EmptyNotificationsScreen(),
        '/panels/directeur/dashboard': (context) => const DirecteurLayout(),
        '/panels/teachers/dashboard':(context)=>const TeachersLayout(),
        '/panels/students/history':(context)=>const CoursesPage(),
        '/panels/students/transactions':(context)=>const TransactionHistoryPage(),
        '/panels/students/dashboard':(context)=>const StudentsLayout()
      },
    );
  }
}


