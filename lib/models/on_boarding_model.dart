// Model for onboarding screens, containing image, title, and body text for each screen and make it easy to change or add new screens.
class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/OnBoarding1.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding2.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding3.jpg',
    title: 'Lorem Ipsum is simply dummy',
    body:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
  ),
];