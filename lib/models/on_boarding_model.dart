// Model for onboarding screens, containing image, title, and body text for each screen and make it easy to change or add new screens.
class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/OnBoarding1.png',
    title: 'Access with Ease',
    body:
        'Access all your projects and tasks anywhere, anytime. Everything you need is just a tap away.',
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding2.png',
    title: 'Track Progress',
    body:
        'Track tasks, deadlines, and progress in real-time. Stay updated and never miss a thing',
  ),
  BoardingModel(
    image: 'assets/images/OnBoarding3.png',
    title: 'Collaborate Better',
    body:
        'Work together with your team in real-time. Share ideas, updates, feedback seamlessly and stay organized.',
  ),
];