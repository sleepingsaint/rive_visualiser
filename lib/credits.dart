import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rive_visualiser/theme.dart';
import 'package:flutter/src/painting/gradient.dart' as MaterialGradient;

class TrailingWidget extends StatelessWidget {
  const TrailingWidget({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.externalLinkAlt,
        color: Colors.white,
        size: MediaQuery.of(context).textScaleFactor * 16.0,
      ),
      onPressed: _launchURL,
    );
  }

  void _launchURL() async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}

class Credits extends StatelessWidget {
  const Credits({Key? key}) : super(key: key);

  final String iconProvider = "flaticon.com";
  final String iconUrl =
      "https://www.flaticon.com/premium-icon/animate_5241678?term=animation&page=1&position=53&page=1&position=53&related_id=5241678&origin=search";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits"),
        backgroundColor: customThemeData.primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: MaterialGradient.LinearGradient(
            colors: [
              customThemeData.primary,
              customThemeData.secondary,
            ],
          ),
        ),
        child: FutureBuilder(
          future: _loadData(context),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List<dynamic> rives = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: customThemeData.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 12.0,
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                          child: Container(
                            alignment: Alignment.center,
                            child: const FaIcon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        title: const Text(
                          "Thanks to all the creators for such an amazing animations.",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: customThemeData.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 10.0,
                      ),
                      child: ListTile(
                        leading: SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                          child: Image.asset(
                            "assets/icon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: Text(
                          "App Icon from $iconProvider",
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        trailing: TrailingWidget(url: iconUrl),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: rives.length,
                      itemBuilder: (context, index) => CreditCard(
                        author: rives[index]["author"],
                        title: rives[index]["title"],
                        rivPath: rives[index]["riv_path"],
                        url: rives[index]["link"],
                      ),
                    ),
                  ),
                ],
              );
              // return Text("data");url_launcher
            }

            if (snapshot.hasError) {
              return const Text("Error");
            }
            return const Text("Loading...");
            // return ListView.builder(itemBuilder: itemBuilder)
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> _loadData(BuildContext context) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/rive.json");
    List<dynamic> jsonResult = jsonDecode(data);
    return jsonResult;
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({
    Key? key,
    required this.rivPath,
    required this.author,
    required this.title,
    required this.url,
  }) : super(key: key);

  final String rivPath, title, author, url;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: customThemeData.cardColor,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.width / 6,
            child: RiveAnimation.asset(
              rivPath,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white70)),
        subtitle: Text(author, style: const TextStyle(color: Colors.white70)),
        trailing: TrailingWidget(url: url),
      ),
    );
  }
}
