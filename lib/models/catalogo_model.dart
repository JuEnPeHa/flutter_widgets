import 'package:flutter/material.dart';

class CatalogoModel {
  final List<CatalogoElementModel> catalogoElements;

  const CatalogoModel({required this.catalogoElements});
}

class CatalogoElementModel {
  final String title;
  final String description;
  final Widget route;

  const CatalogoElementModel({
    required this.title,
    required this.description,
    required this.route,
  });
}
