// Components file I made to avoid code repetition and make the code more organized and reusable. Moreover it makes it easier to maintain and update the code in the future.
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
// import 'package:electropi/modules/details/detail_screen.dart';

// A reusable button widget with customizable properties, used in login screen as login button, profile screens as update and logout buttons
Widget defaultButton({
  required VoidCallback function,
  bool isDisabled = false,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = false,
  double radius = 0.0,
  required String text,
}) => Container(
  width: width,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

// A reusable form field widget with customizable properties, used in login, register and profile screens
Widget defaultFormField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required Function validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPrssed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onChanged: (s) {
    onChange!(s);
  },
  onTap: () {
    onTap!();
  },
  validator: (value) => validate(value),
  enabled: isClickable,
  decoration: InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue), 
    ),
    errorMaxLines: 3,
    labelText: label,
    prefixIcon: prefix != null ? Icon(prefix) : null,
    suffixIcon: suffix != null
        ? IconButton(
            onPressed: () {
              isPassword = !isPassword;
              suffixPrssed!();
            },
            icon: Icon(suffix),
          )
        : null,
    border: OutlineInputBorder(),
  ),
);

// Function to navigate to a new screen, used in onboarding screen to go to login screen and in article item to go to detail screen
Future<dynamic> navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

// Widget to build each article item in the list, used in articleBuilder function
Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    // Calculate hours ago from publishedAt time and pass it to detail screen to display how many hours ago the article was published
    var hours = hour(articleTime: article['publishedAt']);
    // Navigate to detail screen with article details when an article item is tapped using navigateTo function from above to avoid code repetition
    // navigateTo(
    //   context,
    //   DetailScreen(
    //     articleImageURL:
    //         article['urlToImage'] ?? 'https://via.placeholder.com/150',
    //     articleTitle: article['title'] ?? 'No Title',
    //     articleContent: article['content'] ?? 'No Content',
    //     articleSource: article['source']['name'] ?? 'Unknown Source',
    //     articlePublishedTime: hours.toString(),
    //     articleURL: article['url'] ?? '',
    //   ),
    // );
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Category label for the article, defaulting to 'General' if not available
                Text(
                  '${article['category'] ?? 'General'}',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: Text(
                    // Article title with max 2 lines and ellipsis overflow
                    '${article['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10.0,
                      // Placeholder image for article source avatar, can be replaced with actual source logo if available as 'everything' endpoint does not provide source logos
                      backgroundImage: Image(
                        image: AssetImage('assets/images/profile.jpg'),
                      ).image,
                    ),
                    SizedBox(width: 2.0),
                    Expanded(
                      // Article source name with ellipsis overflow if too long
                      child: Text(
                        '${article['source']['name']}',
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Time icon and hours ago text
                    Icon(
                      Icons.access_time_rounded,
                      size: 14.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 3.0),
                    Text(
                      // Calculate hours ago from publishedAt time using hour function below
                      '${hour(articleTime: article['publishedAt'])}h ago',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Spacer(),
                    Icon(Icons.more_horiz, size: 20.0, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

// Widget to build the list of articles with a conditional builder to show a loading indicator if the list is empty, used in home, search and category screens
Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    // List of articles with bouncing scroll physics and separator between items
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => SizedBox(height: 1.0),
    itemCount: list.length,
  ),
  // If the list is empty and it's a search, show nothing, else show a loading indicator
  fallback: (context) => isSearch
      ? Container()
      : Center(child: CircularProgressIndicator(color: Colors.blue)),
);

// Function to calculate how many hours ago an article was published based on its publishedAt time, used in buildArticleItem to display hours ago
int hour({required articleTime}) {
  // Parse the publishedAt time and calculate the difference from current time
  // Example of publishedAt that return from the API: "2023-10-01T12:34:56Z"
  String publishedAt = articleTime;
  // Convert the publishedAt string to DateTime object
  DateTime publishedTime = DateTime.parse(publishedAt);
  // Calculate the difference in hours from current time
  Duration diff = DateTime.now().difference(publishedTime);
  // Return the difference in hours as an integer
  int hoursAgo = diff.inHours;
  return hoursAgo;
}