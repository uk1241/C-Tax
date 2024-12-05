import 'package:c_tax/Screens/dashboard.dart';
import 'package:c_tax/Screens/login.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/auth_provider.dart';

void main() {
  runApp(
    // Commenting out MultiProvider for API
    /*
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
    */
    
    // Running the app directly without provider for now
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C-Tax',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/home': (context) => const HomePage(), // Define your homepage here
      },
    );
  }
}
