import '../models/dish.dart';

class Category {
  final String name;
  final String emoji;
  const Category(this.name, this.emoji);
}

const List<Category> kCategories = [
  Category('All', '🍽️'),
  Category('Burgers', '🍔'),
  Category('Pizza', '🍕'),
  Category('Sushi', '🍣'),
  Category('Salads', '🥗'),
  Category('Drinks', '🥤'),
  Category('Desserts', '🍰'),
];

const List<Dish> kDishes = [
  Dish(
    id: 'b1',
    name: 'Classic Cheeseburger',
    description:
        'Juicy beef patty, melted cheddar, crisp lettuce, tomato and our house sauce in a toasted brioche bun.',
    price: 9.50,
    category: 'Burgers',
    emoji: '🍔',
    rating: 4.8,
    prepMinutes: 15,
    isPopular: true,
  ),
  Dish(
    id: 'b2',
    name: 'Bacon BBQ Burger',
    description:
        'Smoky bacon, double cheese, crispy onion rings and tangy BBQ sauce on a flame-grilled patty.',
    price: 11.90,
    category: 'Burgers',
    emoji: '🍔',
    rating: 4.7,
    prepMinutes: 18,
  ),
  Dish(
    id: 'p1',
    name: 'Margherita Pizza',
    description:
        'San Marzano tomato sauce, fresh mozzarella, basil and a drizzle of extra-virgin olive oil.',
    price: 12.00,
    category: 'Pizza',
    emoji: '🍕',
    rating: 4.9,
    prepMinutes: 22,
    isPopular: true,
  ),
  Dish(
    id: 'p2',
    name: 'Pepperoni Pizza',
    description:
        'Loaded with spicy pepperoni, mozzarella and a rich tomato base on a hand-stretched crust.',
    price: 13.50,
    category: 'Pizza',
    emoji: '🍕',
    rating: 4.6,
    prepMinutes: 22,
  ),
  Dish(
    id: 's1',
    name: 'Salmon Nigiri Set',
    description:
        'Eight pieces of fresh salmon nigiri served with wasabi, pickled ginger and soy sauce.',
    price: 15.00,
    category: 'Sushi',
    emoji: '🍣',
    rating: 4.8,
    prepMinutes: 20,
    isPopular: true,
  ),
  Dish(
    id: 's2',
    name: 'California Roll',
    description:
        'Crab, avocado and cucumber rolled in seasoned rice and nori, topped with sesame seeds.',
    price: 10.50,
    category: 'Sushi',
    emoji: '🍣',
    rating: 4.5,
    prepMinutes: 18,
  ),
  Dish(
    id: 'sl1',
    name: 'Caesar Salad',
    description:
        'Crisp romaine, parmesan shavings, garlic croutons and creamy Caesar dressing.',
    price: 8.00,
    category: 'Salads',
    emoji: '🥗',
    rating: 4.4,
    prepMinutes: 10,
  ),
  Dish(
    id: 'sl2',
    name: 'Greek Salad',
    description:
        'Tomatoes, cucumber, olives, red onion and feta with oregano and olive oil.',
    price: 8.50,
    category: 'Salads',
    emoji: '🥗',
    rating: 4.3,
    prepMinutes: 10,
  ),
  Dish(
    id: 'd1',
    name: 'Fresh Lemonade',
    description: 'Hand-squeezed lemons, a touch of mint and sparkling water.',
    price: 3.50,
    category: 'Drinks',
    emoji: '🥤',
    rating: 4.6,
    prepMinutes: 5,
  ),
  Dish(
    id: 'd2',
    name: 'Iced Caramel Latte',
    description: 'Espresso, cold milk and caramel syrup over ice.',
    price: 4.20,
    category: 'Drinks',
    emoji: '🥤',
    rating: 4.7,
    prepMinutes: 6,
  ),
  Dish(
    id: 'de1',
    name: 'Chocolate Lava Cake',
    description:
        'Warm molten chocolate cake with a scoop of vanilla bean ice cream.',
    price: 6.50,
    category: 'Desserts',
    emoji: '🍰',
    rating: 4.9,
    prepMinutes: 12,
    isPopular: true,
  ),
  Dish(
    id: 'de2',
    name: 'New York Cheesecake',
    description: 'Creamy baked cheesecake with a buttery biscuit base and berry compote.',
    price: 6.00,
    category: 'Desserts',
    emoji: '🍰',
    rating: 4.7,
    prepMinutes: 8,
  ),
];
