import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/houses_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kwanu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const KwanuHomeScreen(),
      routes: {
        '/houses': (context) => const HousesListScreen(),
      },
    );
  }
}
