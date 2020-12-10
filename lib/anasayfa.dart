import 'dart:async';
import 'package:flappybird/engeller.dart';
import 'package:flappybird/kus.dart';
import 'package:flutter/material.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  //fonksiyon degiskenleri
  static double kusYekseni = 0;
  double zaman = 0;
  double yukseklik = 0;
  double ilkYukseklik = 0;
  bool oyunBaslangic = false;
  static double engelXbir = 2;
  double engelXiki = engelXbir + 1.5;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (oyunBaslangic) {
          jump();
        } else {
          oyunBaslarken();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            //gokyuzu temasi
            Expanded(
              flex: 2,
              //Hareketleri algılayan bir widget, dokunmatige duyarli
              child: Stack(
                children: [
                  AnimatedContainer(
                    //kusun hareketi
                    alignment: Alignment(0, kusYekseni),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    //kusu ekledim
                    child: Kus(),
                  ),
                  Container(
                    alignment: Alignment(0, -0.3),
                    child: oyunBaslangic
                        ? Text("")
                        : Text(
                            "BAŞLAMAK İÇİN TIKLA",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(engelXbir, 1.1),
                    child: Engeller(
                      boyut: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(engelXbir, -1.5),
                    child: Engeller(
                      boyut: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(engelXiki, 1.4),
                    child: Engeller(
                      boyut: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    alignment: Alignment(engelXiki, -1),
                    child: Engeller(
                      boyut: 150.0,
                    ),
                  )
                ],
              ),
            ),
            //yer temasi
            Container(
              height: 15,
              color: Colors.green,
            ),
            //yer alti temasi
            Expanded(
                child: Container(
              color: Colors.brown,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PUAN",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("0"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "EN İYİ PUAN",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("0"),
                      ],
                    ),
                  ]),
            )),
          ],
        ),
      ),
    );
  }

  //dokununca yer degistirmesi icin
  void jump() {
    setState(() {
      zaman = 0;
      ilkYukseklik = kusYekseni;
    });
  }

  void oyunBaslarken() {
    oyunBaslangic = true;
    ilkYukseklik = kusYekseni;
    //kodu belli periyotlarda calistirir kusun hizi 60
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      //kusun ziplamasi
      //atis problemlerinden egik atis formulunu kullandim cikari cikip dussun diye
      //g sabiti = 9.8 hiz ise 5 denklem
      //y = -4.9 * t^2 + 5 * t
      zaman += 0.05;
      yukseklik = -4.9 * zaman * zaman + 5 * zaman;

      setState(() {
        if (engelXbir < -1.1) {
          engelXbir += 2.2;
        } else {
          engelXbir -= 0.05;
        }
        if (engelXiki < -1.1) {
          engelXiki += 2.2;
        } else {
          engelXiki -= 0.05;
        }
        //yukari cikariyor(- yukari cikariyor + asagi indiriyor)
        kusYekseni = ilkYukseklik - yukseklik;
      });

      //kus yesil alanin altina dusmesin diye
      if (kusYekseni > 1) {
        timer.cancel();
        oyunBaslangic = false;
      }
    });
  }
}
