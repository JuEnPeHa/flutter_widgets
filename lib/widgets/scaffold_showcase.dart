import 'package:flutter/material.dart';

class ScaffoldShowcase extends StatelessWidget {
  const ScaffoldShowcase({
    super.key,
    required this.appBarTitle,
    required this.body,
  });

  final String appBarTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(appBarTitle),
        ),
      ),
      body: SafeArea(child: body),
    );
  }
}
