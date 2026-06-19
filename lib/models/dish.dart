class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String emoji; // used as a lightweight image placeholder
  final double rating;
  final int prepMinutes;
  final bool isPopular;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.emoji,
    this.rating = 4.5,
    this.prepMinutes = 20,
    this.isPopular = false,
  });
}
