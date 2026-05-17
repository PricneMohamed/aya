import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myhomepage extends StatefulWidget {
  Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoad();
  }

  @override
  List<String> ayat = [
    "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
    "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا",
    "وَاذْكُرْ رَبَّكَ إِذَا نَسِيتَ",
    "وَلَا تَهِنُوا وَلَا تَحْزَنُوا",
    "إِنَّ اللَّهَ مَعَ الصَّابِرِينَ",
    "وَتَوَكَّلْ عَلَى اللَّهِ",
    "حَسْبِيَ اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ",
    "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
    "إِنَّ رَبِّي قَرِيبٌ مُجِيبٌ",
    "وَعَسَى أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ",
    "إِنَّ اللَّهَ يُحِبُّ الصَّابِرِينَ",
    "وَاصْبِرْ وَمَا صَبْرُكَ إِلَّا بِاللَّهِ",
    "فَسَيَكْفِيكَهُمُ اللَّهُ",
    "إِنَّ اللَّهَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ",
    "وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ",
    "رَبِّ اشْرَحْ لِي صَدْرِي",
    "وَيُرِيدُ اللَّهُ أَنْ يَتُوبَ عَلَيْكُمْ",
    "إِنَّ اللَّهَ غَفُورٌ رَحِيمٌ",
    "وَاللَّهُ خَيْرُ الرَّازِقِينَ",
    "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
    "إِنَّ مَعِيَ رَبِّي سَيَهْدِينِ",
    "وَلَا تَيْأَسُوا مِن رَّوْحِ اللَّهِ",
    "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا",
    "وَاللَّهُ يُحِبُّ الْمُتَوَكِّلِينَ",
  ];

  String t = "إِنَّ مَعَ الْعُسْرِ يُسْرًا";
  int run = 0;
  void chooseAya() {
    final random = Random();
    run = random.nextInt(ayat.length);
    chooseText(run);
    setState(() {
      isShow = false;
    });
    print(t);
  }

  void chooseText(num) async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i <= run; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        t = ayat[i];
      });
    }
    await prefs.setString("ayaSaver", ayat[run]);
    await prefs.setInt("time", DateTime.now().millisecondsSinceEpoch);
  }

  bool isShow = true;

  void isLoad() async {
    final prefs = await SharedPreferences.getInstance();

    final time = prefs.getInt("time");
    final word = prefs.getString("ayaSaver");

    if (time == null || word == null) {
      return;
    }

    const oneDay = 24 * 60 * 60 * 1000;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    final diff = currentTime - time;

    setState(() {
      isShow = diff >= oneDay;
      t = word;
    });

    print("word ${word}");
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "24h",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 100,
                color: Colors.teal.withValues(alpha: 0.4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  "$t",
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.05,
              child: isShow
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: chooseAya,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "اية",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
