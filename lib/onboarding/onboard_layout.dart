import 'package:flutter/material.dart';
import 'package:gestuaca/screens/auth/signup_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'welcome.dart';
import 'onboard_one.dart';
import 'onboard_two.dart';
import 'onboard_three.dart';
import 'onboard_four.dart';

class OnboardLayout extends StatefulWidget {
  const OnboardLayout({super.key});

  @override
  State<OnboardLayout> createState() => _OnboardLayoutState();
}

class _OnboardLayoutState extends State<OnboardLayout> {
  final PageController _controller = PageController();
  bool onBoardingComplete = false;
  bool canSkip = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onBoardingComplete = (index == 4);
                if (index < 4) {
                  canSkip = true;
                } else if(index==4) {
                  canSkip = false;
                }
              });
            },
            children: [
              WelcomePage(),
              OnboardOne(),
              OnboardTwo(),
              OnboardThree(),
              OnboardFour(), // Uncomment if you have a fourth onboarding page
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 5,
                    effect: WormEffect(
                      dotHeight: 13,
                      dotColor: Colors.blue.withValues(alpha: 0.2),
                      dotWidth: 13,
                      activeDotColor: Colors.blueAccent[700]!,
                    ),
                  ),
                  SizedBox(height: 10),
                  onBoardingComplete
                      ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Finaliser",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                _controller.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Continuer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(50.0),
              child:
                  canSkip
                      ? GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(4); // Jump to the last page
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Sauter",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 2),
                            Icon(Icons.navigate_next_outlined, color: Colors.blue),

                          ],
                        ),
                      )
                      : GestureDetector(
                        onTap: () {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                              size: 20,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "Retour",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
