import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_visualiser/theme.dart';
import 'package:flutter/src/painting/gradient.dart' as MaterialGradient;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _loadData(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive Visualisations"),
        backgroundColor: customThemeData.primary,
        actions: [
          PopupMenuButton(
            color: customThemeData.teritiary,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("/credits"),
                  child: const Text(
                    "Credits",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pushNamed("/about"),
                  child: const Text(
                    "About Me",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
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
        child: FutureBuilder<List<dynamic>>(
          future: _loadData(context),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              List<dynamic>? rives = snapshot.data;
              return GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  rives?.length ?? 0,
                  (index) => GridTileRive(
                    rivPath: rives![index]["riv_path"]!,
                    routerPath: rives[index]["router_name"]!,
                  ),
                ),
              );
            }

            // TODO: Change this text messages to rive animations
            if (snapshot.hasError) {
              return const Text("Error");
            }

            return const Text("loading");
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

class GridTileRive extends StatelessWidget {
  const GridTileRive({
    Key? key,
    required this.rivPath,
    required this.routerPath,
  }) : super(key: key);

  final String? rivPath;
  final String? routerPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routerPath!),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: RiveAnimation.asset(
            rivPath!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
