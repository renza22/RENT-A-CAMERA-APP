import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'detail_screen.dart';
import 'welcome_screen.dart';
import 'models/item_rental.dart'; // penting biar bisa casting
import 'cart_screen.dart';
import 'payment_screen.dart';
import 'success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/success': (context) => const SuccessScreen(deliveryMethod: "Dijemput Kurir"),
},
      onGenerateRoute: (settings) {
  if (settings.name == '/welcome') {
    final email = settings.arguments as String;
    return MaterialPageRoute(
      builder: (context) => WelcomeScreen(email: email),
    );
  }

  if (settings.name == '/detail') {
    final item = settings.arguments as ItemRental;
    return MaterialPageRoute(
      builder: (context) => DetailScreen(item: item),
    );
  }

  return null;
},

    );
  }
}
