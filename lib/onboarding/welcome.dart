import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeWidget(
        imagePath: 'assets/svg/png2.png',
        title: 'Bienvenue sur',
        description:
            'Bienvenue dans votre univers scolaire digital  de gestion de '
            'votre Universite!',
        prefixText:
            "Avec GestEtu, accédez à toutes vos informations scolaires en "
                "quelques clics.",
      ),
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String prefixText;

  const WelcomeWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Spacer(),
          Image.asset(imagePath, width: 300, height: 250),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent[700],
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'GestEtu',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1), // Adjust the alpha value for transparency
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.withValues(
                alpha: 0.2, // Adjust the alpha value for transparency
              ), width: 1),
            ),
            child: Text(prefixText),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
