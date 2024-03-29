import 'package:flutter/material.dart';
import 'package:flutter_widgets/consts.dart/list_of_elements.dart';

void main() {
  runApp(const MyApp());
}

const _title = 'Catalogo de Widgets';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 66, 177, 98),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: catalogo.catalogoElements
              .map(
                (element) => ListTile(
                  title: Text(element.title),
                  subtitle: Text(element.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => element.route),
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
