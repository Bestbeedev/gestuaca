import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../stores/states.dart';
import '/services/auth_services.dart';
import '/widgets/auth/custom_form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<String> _formErrors = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    _formErrors.clear();
    if (!_formKey.currentState!.validate()) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (result['success'] == false) {
        setState(() {
          _formErrors.add(result['message'] ?? 'Une erreur est survenue.');
        });
        return;
      }

      await Store.setToken(result['token'] ?? "");
      await Store.saveUser(result['user'] ?? "");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                border: Border.all(color: Colors.green[300]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                result['message'] ?? 'Connexion réussie',
                style: TextStyle(color: Colors.green[600]),
              ),
            ),
          ),
        );
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/panels/directeur/dashboard');
      }
    } catch (e) {
      setState(() {
        _formErrors.add('Erreur de connexion. Veuillez réessayer.');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez entrer un email';
    } else {
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if (!emailRegex.hasMatch(value)) {
        return 'Email invalide';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    } else {
      if (value.length < 6) {
        return 'Le mot de passe doit contenir au moins 6 caractères';
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Le mot de passe doit contenir au moins une majuscule';
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Le mot de passe doit contenir au moins un chiffre';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(53),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                        'assets/images/category/gestuacaLogo.png',
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "Connectez-vous",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Connectez-vous à votre compte pour et accéder à vos données.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        hintText: 'Email',
                        isObscure: false,
                        prefixIcon: CupertinoIcons.mail,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        hintText: 'Mot de passe',
                        isObscure: true,
                        prefixIcon: CupertinoIcons.lock,
                      ),
                      const SizedBox(height: 12),

                      /// AuthService error (non lié aux champs)
                      if (_formErrors.any(
                        (e) =>
                            !e.toLowerCase().contains('email') &&
                            !e.toLowerCase().contains('mot de passe'),
                      ))
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _formErrors.firstWhere(
                              (e) =>
                                  !e.toLowerCase().contains('email') &&
                                  !e.toLowerCase().contains('mot de passe'),
                            ),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: GoogleFonts.inter(fontSize: 16),
                          ),
                          child:
                              _isLoading
                                  ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.indigo,
                                      backgroundColor: Colors.white,
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.indigo,
                                      ),
                                    ),
                                  )
                                  : const Text("Se connecter"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey[400], thickness: 1),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/auth/forgot-password');
                        },
                        child: Text(
                          "Mot de passe oublier ?",
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Divider(color: Colors.grey[400], thickness: 1),
                      ),
                    ],
                  ),
                ),

                /// Redirection link
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/auth/signup');
                    },
                    child: Text(
                      "Pas encore un compte ? Inscrivez-vous",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
