import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauthclean/features/application/services/colors.dart';
import 'package:firebaseauthclean/features/application/view/home_view.dart';
import 'package:firebaseauthclean/features/application/view/login_view.dart';
import 'package:firebaseauthclean/features/application/view/note/add_note_view.dart';
import 'package:firebaseauthclean/features/application/view/register_view.dart';
import 'package:firebaseauthclean/features/application/view/splash_view.dart';
import 'package:firebaseauthclean/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            displayLarge: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 26),
            bodySmall: TextStyle(
                color: AppColor.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        scaffoldBackgroundColor: Color(0xFFeaeef7),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPageWrapper(),
        '/home': (context) => const HomePageWrapper(),
        '/login': (context) => const LoginPageWrapper(),
        '/register': (context) => const RegisterPageWrapper(),
        '/newnote': (context) => const AddNotePageWrapper(),
        // '/updatenote': (context) => const UpdateNotePage()
      },
    );
  }
}
