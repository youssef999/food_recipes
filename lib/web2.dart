import 'dart:async';
import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wwe/home.dart';

class RecipeView3 extends StatefulWidget {
  String postUrl;

//  RecipeView3({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView3> {
  int index = 0;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['game', 'mario'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-7757590907378676/8414287857",
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Banner AD $event");
        });
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String finalUrl;
  String url2 =
      "https://www.healthline.com/nutrition/50-super-healthy-foods#bottom-line";

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
    finalUrl = url2;
    if (url2.contains('http://')) {
      finalUrl = url2.replaceAll("http://", "https://");
      print(finalUrl + "this is final url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food Recipes',
              style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.cyan,
          elevation: 6,
        ),
        drawer: Dw(),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: Platform.isIOS ? 60 : 30,
                    right: 24,
                    left: 24,
                    bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: <Widget>[],
                ),
              ),
              Container(
                height: // 200,
                    MediaQuery.of(context).size.height / 1.17 -
                        (Platform.isIOS ? 104 : 30),
                width: MediaQuery.of(context).size.width,
                child: WebView(
                  onPageFinished: (val) {
                    print(val);
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: finalUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      _controller.complete(webViewController);
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
