import 'package:flutter_widgets/models/catalogo_model.dart';
import 'package:flutter_widgets/screens/container/container_page.dart';
import 'package:flutter_widgets/screens/implicit_animations/implicit_animations_page.dart';

const CatalogoModel catalogo = CatalogoModel(catalogoElements: [
  CatalogoElementModel(
    title: 'Container',
    description: 'Pagina de ejemplo de Container',
    route: ContainerPage(),
  ),
  CatalogoElementModel(
    title: 'Implicit Animations',
    description: 'Pagina de ejemplo de Implicit Animations',
    route: ImplicitAnimationsPage(),
  ),
]);
