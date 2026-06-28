import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';

class EmptyProjectsWidget extends StatelessWidget {
  const EmptyProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final circleSize = width * 0.42;
    final iconSize = width * 0.22;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              height: circleSize.clamp(140.0, 190.0),

              width: circleSize.clamp(140.0, 190.0),

              decoration: const BoxDecoration(
                shape: BoxShape.circle,

                color: Color(0xffEEF3FF),
              ),

              child: Icon(
                Icons.inventory_2_outlined,

                size: iconSize.clamp(70.0, 100.0),

                color: primaryColor,
              ),
            ),

            SizedBox(height: width < 360 ? 22 : 28),

            Text(
              "No Projects Yet",

              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: width < 360 ? 24 : 28,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              "You don't have any projects.",

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.grey,

                fontSize: width < 360 ? 14 : 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
