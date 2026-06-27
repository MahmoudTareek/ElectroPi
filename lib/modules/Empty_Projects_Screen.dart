import 'package:electropi/shared/components.dart';
import 'package:flutter/material.dart';

class EmptyProjectsWidget extends StatelessWidget {
  const EmptyProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Container(
              height: 170,
              width: 170,
              decoration:
                  const BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Color(0xffEEF3FF),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 90,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "No Projects Yet",
              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            const Text(
              "You don't have any projects.\nCreate your first project to get started.",
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 180,
              height: 52,
              child: ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryColor,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),
                ),
                onPressed: () {

                  /// navigate to create project
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  "New Project",
                  style: TextStyle(
                    color:
                        Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}