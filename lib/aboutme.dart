import 'package:flutter/material.dart';
import 'package:rive_visualiser/theme.dart';
import 'package:flutter/src/painting/gradient.dart' as MaterialGradient;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);
  final String githubUrl = "https://github.com/sleepingsaint";
  final String repoUrl = "https://github.com/sleepingsaint/rive_visualiser";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Me"),
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Made with Rive and Flutter by",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    "sleepingsaint",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              color: customThemeData.cardColor,
              child: ListTile(
                leading:
                    const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                title: const Text(
                  "Check out the project source code",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () => _launchURL(repoUrl),
                  icon: FaIcon(
                    FontAwesomeIcons.externalLinkAlt,
                    color: Colors.white,
                    size: 16.0 * MediaQuery.of(context).textScaleFactor,
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              color: customThemeData.cardColor,
              child: ListTile(
                leading:
                    const FaIcon(FontAwesomeIcons.github, color: Colors.white),
                title: const Text(
                  "Check out my other projects",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () => _launchURL(githubUrl),
                  icon: FaIcon(
                    FontAwesomeIcons.externalLinkAlt,
                    color: Colors.white,
                    size: 16.0 * MediaQuery.of(context).textScaleFactor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $githubUrl';
  }
}
