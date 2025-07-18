import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardFour extends StatelessWidget {
  const OnboardFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardContentWidget(
        imagePath: "assets/svg/svgfive.svg",
        title: " Gestion des notes et des absences",
        description:
            "Consultez vos notes, suivez votre progression académique et gérez vos absences en temps réel.",
      ),
    );
  }
}

class OnboardContentWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardContentWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
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
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}