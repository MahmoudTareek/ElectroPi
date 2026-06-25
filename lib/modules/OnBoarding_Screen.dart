import 'package:flutter/material.dart';
import 'package:electropi/models/on_boarding_model.dart';
import 'package:electropi/modules/Login_Screen.dart';
import 'package:electropi/shared/components.dart';
import 'package:electropi/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController boardController = PageController();

  bool isLast = false;
  bool isFirst = true;

  Future<void> submit() async {
    await CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              physics: const BouncingScrollPhysics(),

              onPageChanged: (index) {
                setState(() {
                  isLast = index == boarding.length - 1;
                  isFirst = index == 0;
                });
              },

              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),

              itemCount: boarding.length,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),

            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,

                  effect: const ScrollingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                  ),

                  count: boarding.length,
                ),

                const Spacer(),

                if (!isFirst)
                  TextButton(
                    onPressed: () {
                      boardController.previousPage(
                        duration: const Duration(
                          milliseconds: 400,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },

                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                    ),
                  ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                  ),

                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInOut,
                      );
                    }
                  },

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),

                    child: Text(
                      isLast
                          ? 'Get Started'
                          : 'Next',

                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Expanded(
          flex: 4,

          child: Image.asset(
            model.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  model.title,

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  model.body,

                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}