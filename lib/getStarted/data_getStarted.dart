class OnBoarding {
  final String title;
  final String image;
  final String description;

  OnBoarding({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
      title: 'REVIVE THE SPIRIT OF\n YOUR BOOK',
      image: 'assets/seller2.gif',
      description: 'Give to your book\nexperience and another life '
  ),
  OnBoarding(
      title: 'DISCOVER NEW METHODS\n TO LEARN BOOKS',
      image: 'assets/loverbook2.gif',
      description: 'Here you can simply Discover\nSome New and original Book'
  ),
  OnBoarding(
      title: 'DISCOVER NEW BOOKS\n AUTHORS PRICES',
      image: 'assets/author2.gif',
      description: 'Search your book and You will\nfind a lot of type in your city'
  ),
  OnBoarding(
      title: 'E-BIBLIO\n MARKET PLACE',
      image: 'assets/cash2.gif',
      description: 'Give to your book\nexperience and another life'
  ),
];