import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardThree extends StatelessWidget {


  // final String prefixText =
  const OnboardThree({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardContentWidget(
        imagePath: "assets/svg/svgfour.svg",
        title: " Notifications et emploi du temps",
        description:
            "Restez informé des changements d'emploi du temps, des annonces et des messages de l’administration.",
      ),
    );
  }
}

class OnboardContentWidget extends StatelessWidget {
  const OnboardContentWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final String imagePath;
  final String title;
  final String description;

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
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
