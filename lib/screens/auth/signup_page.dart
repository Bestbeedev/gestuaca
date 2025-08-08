import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../stores/states.dart';
import '/services/auth_services.dart';
import '/widgets/auth/custom_form_fields.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
   String _errorMessage='';

  void _submit() async {

    // 1. Réinitialise les erreurs du formulaire
    _errorMessage = "";


    // 2. Valide les champs
    if (!_formKey.currentState!.validate()) {
      setState(() {}); // Forcer le redraw si erreurs visibles
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 3. Appel API via AuthService
    try {

      final result = await _authService.register(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 4. Gestion des erreurs serveur (par exemple credentials invalides)
      if (result['success'] == false) {
        setState(() {
          _errorMessage = result['message'] ?? "Erreur lors de l'inscription";
        });
        return;
      }

      // 5. Sauvegarde token + user
      
      await Store.setToken(result['token'] ?? "");
      
      // 6. SnackBar de succès
      if(mounted){
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
                result['message'] ?? 'Inscription réussie',
                style: TextStyle(color: Colors.green[600]),
              ),
            ),
          ),
        );
      }


      // 7. Redirection si le widget est toujours monté
      if (mounted) {
        Navigator.pushReplacementNamed(
            context,
            '/auth/user-type-info',
          arguments: {
            'email': _emailController.text.trim(),
            'username': _usernameController.text.trim(),
          },);
      }

    } catch (e) {
      // 8. Erreur réseau ou exception
      setState(() {
        _errorMessage='Erreur de connexion. Veuillez réessayer.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Validation des champs

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Veuillez entrer un nom d'utilisateur";
    }
    if (value.length < 3) {
      return "Le nom d'utilisateur doit contenir au moins 3 caractères";
    }
    return null;
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
                SizedBox(height: 8,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/mortarboard-fill.svg",
                        width: 25,
                        height: 25,
                        colorFilter: ColorFilter.mode(
                          Colors.indigo,
                          BlendMode.srcIn,
                        ),
                      ),
                      Text(
                        "GestEtu",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 15),
                Text(
                  "Créez votre compte",
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
                    "Rejoignez-nous pour accéder à toutes les fonctionnalités",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Formulaire
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: _usernameController,
                        validator: _validateUsername,
                        hintText: 'Nom complet',
                        prefixIcon: CupertinoIcons.person,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: _validateEmail,
                        hintText: 'Email',
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
                      // Error message for the whole form
                      if (_errorMessage.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Sign up button
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
                              : const Text("S'inscrire"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Already have an account
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/auth/login');
                    },
                    child: Text(
                      "Déjà un compte ? Connectez-vous",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Terms of use
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "En créant un compte, vous acceptez nos ",
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
                      children: [
                        TextSpan(
                          text: "Conditions d'utilisation et notre Politique de confidentialité.",
                          style: const TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


