import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardTwo extends StatelessWidget {
  const OnboardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardContentWidget(
        title:
            "Paiements & inscriptions digitalisés.",
        description:
            "Inscrivez-vous, payez vos "
                "frais et suivez vos dossiers en toute transparence.",
        imagePath: 'assets/svg/svg3.svg',
        prefixText:
            "Avec GestEtu, accédez à toutes vos informations scolaires en quelques clics.",
      ),
    );
  }
}

class OnboardContentWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String prefixText;

  const OnboardContentWidget({
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
          //Image.asset(imagePath, width: 250, height: 250),
          SvgPicture.asset(imagePath, width: 180, height: 200),

          SizedBox(height: 40,),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 30),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
