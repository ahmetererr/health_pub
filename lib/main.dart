import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/register_page.dart';
import 'package:ecommerce/pages/signin_page.dart';
import 'package:ecommerce/pages/welcome_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      title: 'health app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff5a73d8),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      // Determine the home screen
      initialRoute: SplashScreen.routeName,
      // Define page routes
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomePage(), //This is the pages we call maine
        '/register': (context) => RegisterPage(),
        '/signin': (context) => SignInPage(),
        '/home': (context) =>  HomePage(""),

      },
    );
  }
}
