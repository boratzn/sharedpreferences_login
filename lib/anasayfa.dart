import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login/main.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String? spKullaniciAdi;
  String? spSifre;

  Future<void> oturumBilgisiOku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("ka") ?? "Kullanıcı adı yok..";
      spSifre = sp.getString("s") ?? "Şifre yok..";
    });
  }

  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("ka");
    sp.remove("s");

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginEkrani(),
        ));
  }

  @override
  void initState() {
    super.initState();
    oturumBilgisiOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anasayfa"),
        actions: [
          IconButton(
              onPressed: () {
                cikisYap();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Kullanıcı Adı : $spKullaniciAdi",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "Şifre : $spSifre",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
