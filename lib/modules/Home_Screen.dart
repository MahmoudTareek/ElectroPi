// // Home Screen with news categories and articles list with pull-to-refresh functionality
// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:electropi/cubit/cubit.dart';
// import 'package:electropi/cubit/states.dart';
// import 'package:electropi/shared/components.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String selectedCategory = 'all';
//   // List of news categories available for filtering articles selected by user as 'everything' in API don't return categories.
//   final List<String> categories = [
//     'all',
//     'business',
//     'entertainment',
//     'general',
//     'health',
//     'science',
//     'sports',
//     'technology',
//   ];

//   @override
//   @override
//   void initState() {
//     super.initState();
//     // Fetch all news articles when the screen is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       NewsCubit.get(context).getAllNews();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    // return BlocConsumer<NewsCubit, ProjectStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = NewsCubit.get(context);
//         var list = cubit.allNews;
//         if (list.isEmpty) {
//           // Show a friendly message to user if no articles are available
//           Fluttertoast.showToast(
//             msg: "No Articles Available.",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.yellow,
//             textColor: Colors.black,
//             fontSize: 16.0,
//           );
//         }
//         // Implementing pull-to-refresh functionality using CustomRefreshIndicator package
//         return CustomRefreshIndicator(
//           onRefresh: () async {
//             if (selectedCategory == 'all') {
//               cubit.getAllNews();
//             } else {
//               // Return to 'all' category on refresh to ensure user sees latest articles across all categories
//               selectedCategory = 'all';
//               cubit.getAllNews();
//             }
//           },
//           builder:
//               (
//                 BuildContext context,
//                 Widget child,
//                 IndicatorController controller,
//               ) {
//                 // Custom animation for the pull-to-refresh indicator
//                 return AnimatedBuilder(
//                   animation: controller,
//                   builder: (BuildContext context, _) {
//                     return Stack(
//                       alignment: Alignment.topCenter,
//                       children: [
//                         if (!controller.isIdle)
//                           Positioned(
//                             top: 35.0 * controller.value - 30,
//                             child: SizedBox(
//                               height: 30,
//                               width: 30,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.0,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.blue,
//                                 ),
//                                 value: controller.isLoading
//                                     ? null
//                                     : controller.value,
//                               ),
//                             ),
//                           ),
//                         // Translate the main content down as the user pulls to refresh
//                         Transform.translate(
//                           offset: Offset(0, 35.0 * controller.value),
//                           child: child,
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//           // The main content of the HomeScreen including categories and articles list
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 22.0),
//                   child: Row(
//                     children: [
//                       Text(
//                         "Latest",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Spacer(),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "See all",
//                           style: TextStyle(fontSize: 14, color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Container(
//                   height: 40,
//                   child: ListView.separated(
//                     // Horizontal list of categories for filtering articles
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.only(left: 18.0),
//                     itemBuilder: (context, index) {
//                       final category = categories[index];
//                       final isSelected = category == selectedCategory;
//                       return GestureDetector(
//                         // Update selected category and fetch corresponding articles
//                         onTap: () {
//                           setState(() {
//                             selectedCategory = category;
//                           });
//                           if (category == 'all') {
//                             cubit.getAllNews();
//                           } else {
//                             cubit.getNewsByCategory(category);
//                           }
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 5,
//                             vertical: 8,
//                           ),
//                           // Highlight the selected category
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: isSelected
//                                     ? Colors.blue
//                                     : Colors.transparent,
//                                 width: 3.0,
//                               ),
//                             ),
//                           ),
//                           // Category name in uppercase
//                           child: Center(
//                             child: Text(
//                               category.toUpperCase(),
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: isSelected
//                                     ? FontWeight.bold
//                                     : FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) => SizedBox(width: 3.0),
//                     itemCount: categories.length,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Display the list of articles based on selected category or all articles, using articleBuilder from components.dart to be easily reusable in other screens if I want to show list of articles there too.
//                 articleBuilder(list, context),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }