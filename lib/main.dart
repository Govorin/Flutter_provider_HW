import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ColorProvider>.value(value: ColorProvider())
        ],
        child: Page(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  @override
  PageState createState() => PageState();
}

class PageState extends State {
  bool isInstructionView = false;
  Widget build(BuildContext context) {
    ColorProvider state = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROVIDER HEADER',
          style: TextStyle(color: state.headerColor),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              height: 200,
              width: 200,
              color: state.boxColor,
              duration: Duration(seconds: 1),
            ),
            Consumer<ColorProvider>(
              builder: (context, value, child) {
                return Switch(
                  onChanged: (value) {
                    state.changeColors();
                    isInstructionView = value;
                  },
                  value: isInstructionView,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ColorProvider extends ChangeNotifier {
  Color headerColor = getColor();
  Color boxColor = getColor();

  void changeColors() {
    headerColor = getColor();
    boxColor = getColor();
    notifyListeners();
  }

  static Random random = new Random();

  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
