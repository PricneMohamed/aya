import 'package:aya/screen/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AYA',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 58, 133, 183),
        ),
        textTheme: GoogleFonts.cairoTextTheme()
            .copyWith(
              titleLarge: GoogleFonts.cairo(
                color: Colors.teal,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            )
            .copyWith(
              titleSmall: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      locale: Locale("ar"),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar"), Locale("en")],
      home: Myhomepage(),
    );
  }
}
