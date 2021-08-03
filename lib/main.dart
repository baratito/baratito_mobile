import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ThemeProvider(child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}
