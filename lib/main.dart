import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> oturumKontrol() async {
      var sp = await SharedPreferences.getInstance();

      String spKullaniciAdi = sp.getString("ka") ?? "Kullanıcı adı yok..";
      String spSifre = sp.getString("s") ?? "Şifre yok..";

      if (spKullaniciAdi == "admin" && spSifre == "123") {
        return true;
      } else {
        return false;
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool gecisIzni = snapshot.data!;
            return gecisIzni ? Anasayfa() : LoginEkrani();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LoginEkrani extends StatefulWidget {
  @override
  State<LoginEkrani> createState() => _LoginEkraniState();
}

class _LoginEkraniState extends State<LoginEkrani> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if (ka == "admin" && s == "123") {
      var sp = await SharedPreferences.getInstance();

      sp.setString("ka", ka);
      sp.setString("s", s);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Anasayfa(),
          ));
    } else {
      var snackbarContent =
          const SnackBar(content: Text("Kullanıcı adı veya şifre yanlış!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbarContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: tfKullaniciAdi,
                decoration: const InputDecoration(hintText: "Kullanıcı Adı"),
              ),
              TextField(
                obscureText: true,
                controller: tfSifre,
                decoration: const InputDecoration(hintText: "Şifre"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await girisKontrol();
                  },
                  child: Text("Giriş Yap"))
            ],
          ),
        ),
      ),
    );
  }
}
