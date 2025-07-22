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
  final _tokenStore = Stores();


  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<String> _formErrors = [];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _submit() async {
    // 1. Réinitialise les erreurs du formulaire
    _formErrors.clear();

    // 2. Valide les champs
    if (!_formKey.currentState!.validate()) {
      setState(() {}); // Forcer le redraw si erreurs visibles
      return;
    }

    // 3. Appel API via AuthService
    try {
      final result = await _authService.login(
       email:_emailController.text.trim(),
        password: _passwordController.text
      );

      // 4. Gestion des erreurs serveur (par exemple credentials invalides)
      if (result['success'] == false) {
        setState(() {
          _formErrors.add(result['message'] ?? 'Une erreur est survenue.');
        });
        return;
      }

      // 5. Sauvegarde token + user
      await _tokenStore.saveToken(result['token'] ?? "");
      await _tokenStore.saveUser(result['user'] ?? {});

      //print(await _tokenStore.getUser());
      // 6. SnackBar de succès
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

      // 7. Redirection si le widget est toujours monté
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/panels/directeur/dashboard',
        );
      }
    } catch (e) {
      // 8. Erreur réseau ou exception
      setState(() {
        _formErrors.add('Erreur de connexion. Veuillez réessayer.');
      });
    } finally {
      setState(() {}); // Redessiner le formulaire avec les erreurs ou après succès
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
                const SizedBox(height: 32),
                Text(
                  "Connectez-vous",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Connectez-vous à votre compte pour et accéder à vos données.",
                    style: GoogleFonts.inter(
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
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: _validatePassword,
                        hintText: 'Mot de passe',
                        isObscure: true,
                      ),
                      const SizedBox(height: 12),

                      /// AuthService error (non lié aux champs)
                      if (_formErrors.any((e) =>
                      !e.toLowerCase().contains('email') &&
                          !e.toLowerCase().contains('mot de passe')))
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _formErrors
                                .firstWhere((e) =>
                            !e.toLowerCase().contains('email') &&
                                !e.toLowerCase().contains('mot de passe')),
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
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: GoogleFonts.inter(fontSize: 16),
                          ),
                          child: const Text("Se connecter"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

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
