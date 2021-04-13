import 'package:alert_dialog/alert_dialog.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wwe/RecipeView.dart';
import 'dart:io';
import 'dart:convert';

import 'package:wwe/models/Reciepe.dart';
import 'package:wwe/web.dart';
import 'package:wwe/web2.dart';

const String testDevice = 'Mobile_id';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  InterstitialAd createInterAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-7757590907378676/5788124510",
        // size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    //  super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    //   super.dispose();
  }

  TextEditingController textEditingController = new TextEditingController();

  List<RecipeModel> recipies = new List();
  String AppId = '782821a8';
  String AppKeyy = 'bbd89cdfa34b4dbe023e87c93facedf2';
  bool _loading = false;

  getRecieps(String query) async {
    String url =
        'https://api.edamam.com/search?q=$query&app_id=782821a8&app_key=bbd89cdfa34b4dbe023e87c93facedf2&health=alcohol-free"';
    //&health=alcohol-free"
    var response = await http.get(url);
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      print(element.toString());

      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipies.add(recipeModel);
    });
    print(recipies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Recipes',
              style: TextStyle(fontStyle: FontStyle.italic)),
          backgroundColor: Colors.cyan,
          elevation: 6,
        ),
        drawer: Dw(),
        body: Stack(
          children: [
            Container(
              // color:Colors.blue[900],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              //color:Colors.,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color(0xffafafa),
                const Color(0xff00acc1),
              ])),
            ),
            SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: !kIsWeb
                            ? Platform.isIOS
                                ? 60
                                : 30
                            : 30,
                        horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              left: 130,
                              top: 6,
                            ),
                            child: Row(
                              children: [
                                Center(
                                  child: Text("Recipes",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 21,
                                          fontStyle: FontStyle.italic)),
                                )
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text("What will you cook today ?",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontStyle: FontStyle.italic)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                              "just Enter Ingredient you have and we will show best results..",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Row(children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: textEditingController,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Overpass'),
                                decoration: InputDecoration(
                                    hintText:
                                        "  Enter Main Category Of Food ..  ",
                                    hintStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.5),
                                        fontFamily: 'Overpass'),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            InkWell(
                              onTap: () async {
                                if (textEditingController.text == 'vodka') {
                                  createInterAd()
                                    ..load()
                                    ..show();
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Vodka') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'VODKA') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'WINE') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'wine') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'red wine') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Redwine') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'zinger') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Wine') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text ==
                                    'Sliced Bacon') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'bacon') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text ==
                                    'beef bacon') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text ==
                                    'pork smoked jowl') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text ==
                                    'pork spare rips') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }

                                if (textEditingController.text ==
                                    'Pork spare rips') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'beer') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'BEER') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Beer') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'suju') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'SUJU') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Suju') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'shampine') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'pork') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'PORK') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Pork') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'ham') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Ham') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'HAM') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'BURGER') {
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'burger') {
                                  createInterAd()
                                    ..load()
                                    ..show();
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                                if (textEditingController.text == 'Burger') {
                                  createInterAd()
                                    ..load()
                                    ..show();
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }

                                if (textEditingController.text.isNotEmpty) {
                                  getRecieps(textEditingController.text);
                                  print("done");
                                  setState(() {
                                    _loading = true;
                                  });
                                  recipies = new List();
                                  String url =
                                      "https://api.edamam.com/search?q=${textEditingController.text}&app_id=0f21d949&app_key=8bcdd93683d1186ba0555cb95e64ab26";
                                  var response = await http.get(url);
                                  print(" $response this is response");
                                  Map<String, dynamic> jsonData =
                                      jsonDecode(response.body);
                                  print("this is json Data $jsonData");
                                  jsonData["hits"].forEach((element) {
                                    print(element.toString());
                                    RecipeModel recipeModel = new RecipeModel();
                                    recipeModel =
                                        RecipeModel.fromMap(element['recipe']);
                                    recipies.add(recipeModel);
                                    print(recipeModel.url);
                                  });
                                  setState(() {
                                    _loading = false;
                                  });

                                  print("doing it");
                                } else {
                                  createInterAd()
                                    ..load()
                                    ..show();
                                  return alert(context,
                                      title: Text('Sorry can not find'));
                                }
                              },
                              child: Container(
                                  child:
                                      Icon(Icons.search, color: Colors.white)),
                            )
                          ]),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      mainAxisSpacing: 12.0,
                                      maxCrossAxisExtent: 210.0),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: ClampingScrollPhysics(),
                              children: List.generate(recipies.length, (index) {
                                return GridTile(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: RecipieTile(
                                      title: recipies[index].label,
                                      imgUrl: recipies[index].image,
                                      desc: recipies[index].source,
                                      url: recipies[index].url,
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}

/*class RecipeTile extends StatelessWidget {
  String url, postUrl, source, title;
  RecipeTile({this.url, this.postUrl, this.source, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[Image.network(url),
      Container(
        child:Column(
          children:<Widget> [
            Text(title),
            Text(source),

          ],
        )
      )




      ],

    ));
  }
}
*/
class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({this.title, this.desc, this.imgUrl, this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
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

  InterstitialAd createInterAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-7757590907378676/5788124510",
        // size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        });
  }

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              createInterAd()
                ..load()
                ..show();
              _launchURL(widget.url);
            } else {
              createInterAd()
                ..load()
                ..show();
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                            postUrl: widget.url,
                            // img:widget.imgUrl,
                            //  title:widget.title,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
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

  InterstitialAd createInterAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-7757590907378676/5788124510",
        // size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        });
  }

  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {this.topColor,
      this.bottomColor,
      this.topColorCode,
      this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dw extends StatelessWidget {
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

  InterstitialAd createInterAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-7757590907378676/5788124510",
        // size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(''),
          accountName: Text(''),
          currentAccountPicture: CircleAvatar(child: (Icon(Icons.fastfood))),
          decoration: BoxDecoration(
              //color:Colors.black,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://ak.picdn.net/shutterstock/videos/1014076202/thumb/9.jpg"),
                  fit: BoxFit.cover)),
        ),
        ListTile(
          title: Text(" About Healthy Food"),
          leading: Icon(Icons.no_food_rounded, color: Colors.blue, size: 25),
          onTap: () {
            createInterAd()
              ..load()
              ..show();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return RecipeView3();
              }),
            );
          },
        ),
        ListTile(
          title: Text("Home"),
          leading: Icon(Icons.home, color: Colors.blue, size: 25),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return Home();
              }),
            );
          },
        ),
        ListTile(
          title: Text("Start clean Eating "),
          leading: Icon(Icons.favorite_rounded, color: Colors.blue, size: 25),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return RecipeView2();
              }),
            );
          },
        )
      ],
    ));
  }
}
