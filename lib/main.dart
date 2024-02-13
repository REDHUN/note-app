import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauthclean/features/application/view/home_view.dart';
import 'package:firebaseauthclean/features/application/view/login_view.dart';
import 'package:firebaseauthclean/features/application/view/register_view.dart';
import 'package:firebaseauthclean/features/application/view/splash_view.dart';
import 'package:firebaseauthclean/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
            bodySmall: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        scaffoldBackgroundColor: Color(0xfff263147),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPageWrapper(),
        '/home': (context) => const HomePageWrapper(),
        '/login': (context) => const LoginPageWrapper(),
        '/register': (context) => const RegisterPageWrapper()
      },
    );
  }
}
