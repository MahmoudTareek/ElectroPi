import 'package:flutter/material.dart';
import 'package:electropi/models/on_boarding_model.dart';
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
    await CacheHelper.saveData(key: 'onboarding_done', value: true);

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff121212) : Colors.white,

      body: SafeArea(
        child: Column(
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
                    buildBoardingItem(context, boarding[index]),

                itemCount: boarding.length,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * .05,

                vertical: height * .02,
              ),

              child: Row(
                children: [
                  Expanded(
                    child: SmoothPageIndicator(
                      controller: boardController,

                      count: boarding.length,

                      effect: ScrollingDotsEffect(
                        dotColor: isDark ? Colors.white24 : Colors.grey,

                        activeDotColor: primaryColor,

                        dotHeight: width < 360 ? 8 : 10,

                        dotWidth: width < 360 ? 8 : 10,

                        spacing: 6,
                      ),
                    ),
                  ),

                  if (!isFirst)
                    TextButton(
                      onPressed: () {
                        boardController.previousPage(
                          duration: const Duration(milliseconds: 400),

                          curve: Curves.easeInOut,
                        );
                      },

                      child: Text(
                        'Back',

                        style: TextStyle(
                          color: isDark
                              ? Colors.white70
                              : primaryColor.withOpacity(.5),

                          fontSize: width < 360 ? 14 : 16,
                        ),
                      ),
                    ),

                  SizedBox(width: width * .02),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,

                      minimumSize: Size(
                        width < 360 ? 110 : 130,

                        width < 360 ? 45 : 50,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                          duration: const Duration(milliseconds: 500),

                          curve: Curves.easeInOut,
                        );
                      }
                    },

                    child: Text(
                      isLast ? 'Get Started' : 'Next',

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: width < 360 ? 14 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
