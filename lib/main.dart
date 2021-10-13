import 'package:flutter/material.dart';
import 'package:pokemon_example/provider/pokemon_provider.dart';
import 'package:pokemon_example/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MaterialApp(
        title: 'Pokemon Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
