import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class OnboardOne extends StatelessWidget {
  const OnboardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardContentWidget(
        imagePath: 'assets/svg/svg2.svg',
        title: "Consultez vos matieres et notes en temps réel",
        description:
            "Avec GestEtu, accédez à toutes vos informations scolaires en quelques clics.",
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
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(3.1416), // π radians = flip horizontal
            child: SvgPicture.asset(
              imagePath,
              width: 200,
              height: 250,
            ),
          ),
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
