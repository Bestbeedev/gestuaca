import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth/custom_form_fields.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: LogoWithTitle(
        title: 'Mot de passe oublié',
        subText:
            "Renseignez votre mail et votre mot de passe pour changer le mot "
                "de passe ",
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Form(
              key: _formKey,
              child: CustomTextFormField(
                controller: _emailController,
                prefixIcon: CupertinoIcons.mail,
                validator: _validateEmail,
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Form(
              key: _formKey,
              child: CustomTextFormField(
                controller: _passwordController,
                validator: _validatePassword,
                hintText: 'Nouveau mot de passe',
               isObscure: true,
                prefixIcon: CupertinoIcons.lock,

              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            child: const Text("Continuer"),
          ),
        ],
      ),
    );
  }
}

class LogoWithTitle extends StatelessWidget {
  final String title, subText;
  final List<Widget> children;

  const LogoWithTitle({
    super.key,
    required this.title,
    this.subText = '',
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.1),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: double.infinity,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    subText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color!.withValues(alpha: 0.64),
                    ),
                  ),
                ),
                ...children,
              ],
            ),
          );
        },
      ),
    );
  }
}
