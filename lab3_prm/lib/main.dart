/*
 * Lab 3 – Advanced Dart Practice Exercises
 * Author: Student
 */

import 'dart:async';

// ===============================
// MAIN FUNCTION
// ===============================
Future<void> main() async {
  print('========== EXERCISE 1 ==========');
  await exercise1();

  print('\n========== EXERCISE 2 ==========');
  await exercise2();

  print('\n========== EXERCISE 3 ==========');
  exercise3();

  // Delay for async order
  await Future.delayed(Duration(seconds: 1));

  print('\n========== EXERCISE 4 ==========');
  await exercise4();

  print('\n========== EXERCISE 5 ==========');
  exercise5();
}

// =====================================================
// EXERCISE 1 – PRODUCT MODEL & REPOSITORY
// =====================================================

// Product model
class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return '$id - $name - \$${price.toStringAsFixed(2)}';
  }
}

// Repository
class ProductRepository {
  // StreamController for live updates
  final StreamController<Product> _controller =
  StreamController<Product>.broadcast();

  // Sample product list
  final List<Product> _products = [
    Product(1, 'Laptop', 1200),
    Product(2, 'Mouse', 25),
  ];

  // Future method
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));

    return _products;
  }

  // Stream method
  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Add product
  void addProduct(Product product) {
    _products.add(product);

    _controller.add(product);
  }
}

Future<void> exercise1() async {
  ProductRepository repo = ProductRepository();

  // Listen to stream
  repo.liveAdded().listen((product) {
    print('New Product: $product');
  });

  // Get all products
  List<Product> products = await repo.getAll();

  for (Product p in products) {
    print(p);
  }

  // Add new product
  repo.addProduct(Product(3, 'Keyboard', 50));
}

// =====================================================
// EXERCISE 2 – USER REPOSITORY WITH JSON
// =====================================================

// User model
class User {
  String name;
  String email;

  User(this.name, this.email);

  // fromJson constructor
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  @override
  String toString() {
    return '$name - $email';
  }
}

Future<List<User>> fetchUsers() async {
  await Future.delayed(Duration(seconds: 1));

  // Simulated JSON data
  List<Map<String, dynamic>> jsonData = [
    {
      'name': 'Tung',
      'email': 'tung@gmail.com',
    },
    {
      'name': 'Anna',
      'email': 'anna@gmail.com',
    }
  ];

  // Convert JSON to User objects
  return jsonData.map((json) => User.fromJson(json)).toList();
}

Future<void> exercise2() async {
  List<User> users = await fetchUsers();

  for (User user in users) {
    print(user);
  }
}

// =====================================================
// EXERCISE 3 – ASYNC + MICROTASK DEBUGGING
// =====================================================
void exercise3() {
  print('Start');

  // Microtask queue
  scheduleMicrotask(() {
    print('Microtask');
  });

  // Event queue
  Future(() {
    print('Future Event');
  });

  print('End');
}

/*
Expected order:
1. Start
2. End
3. Microtask
4. Future Event

Microtasks execute before event queue callbacks.
*/

// =====================================================
// EXERCISE 4 – STREAM TRANSFORMATION
// =====================================================
Future<void> exercise4() async {
  // Stream of numbers
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Square values
  Stream<int> squared = numbers.map((n) => n * n);

  // Filter even squares
  Stream<int> evenNumbers = squared.where((n) => n % 2 == 0);

  // Listen to stream
  await for (int value in evenNumbers) {
    print(value);
  }
}

// =====================================================
// EXERCISE 5 – FACTORY CONSTRUCTORS & CACHE
// =====================================================

class Settings {
  // Singleton instance
  static final Settings _instance = Settings._internal();

  // Private constructor
  Settings._internal();

  // Factory constructor
  factory Settings() {
    return _instance;
  }
}

void exercise5() {
  Settings a = Settings();
  Settings b = Settings();

  // Check same object
  print(identical(a, b));
}