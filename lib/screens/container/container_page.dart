import 'package:flutter/material.dart';
import 'package:flutter_widgets/screens/container/widgets/box_decoration_selector.dart';
import 'package:flutter_widgets/screens/container/widgets/slider_color_selector.dart';
import 'package:flutter_widgets/screens/container/widgets/slider_size_selector.dart';
import 'package:flutter_widgets/widgets/scaffold_showcase.dart';

const Divider divider = Divider(
  height: 5,
  thickness: 2,
  color: Colors.black,
);

const Expanded spacer = Expanded(
  flex: 1,
  child: SizedBox.shrink(),
);

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  BoxDecoration _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.blue,
    border: noBorder,
  );

  double? nuevaAlturaDelContainer;
  double? nuevoAnchoDelContainer;

  @override
  Widget build(BuildContext context) {
    return ScaffoldShowcase(
      appBarTitle: 'Container',
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double alturaDeCadaMitad = (constraints.maxHeight / 2) - 5;
        final double anchoDeCadaMitad = constraints.maxWidth;

        nuevaAlturaDelContainer ??= alturaDeCadaMitad / 2;
        nuevoAnchoDelContainer ??= anchoDeCadaMitad / 2;

        return Column(
          children: [
            SizedBox(
              height: alturaDeCadaMitad,
              width: anchoDeCadaMitad,
              child: Center(
                child: Container(
                  width: nuevoAnchoDelContainer,
                  height: nuevaAlturaDelContainer,
                  decoration: _boxDecoration,
                  child: const Center(
                    child: Text(
                      'Container',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            divider,
            SizedBox(
              height: alturaDeCadaMitad,
              width: anchoDeCadaMitad,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        spacer,
                        Expanded(
                          flex: 2,
                          child: SliderColorSelector(
                            initialColor: _boxDecoration.color as Color,
                            onChangeColor: (color) {
                              setState(() {
                                _boxDecoration = _boxDecoration.copyWith(
                                  color: color,
                                );
                              });
                            },
                          ),
                        ),
                        spacer,
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 5,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        spacer,
                        spacer,
                        Expanded(
                          flex: 2,
                          child: SliderSizeSelector(
                            initialSize: Size(nuevoAnchoDelContainer ??= 0,
                                nuevaAlturaDelContainer ??= 0),
                            maxSize: Size(anchoDeCadaMitad, alturaDeCadaMitad),
                            onChangeSize: (value) {
                              setState(() {
                                nuevoAnchoDelContainer = value.width;
                                nuevaAlturaDelContainer = value.height;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: BoxDecorationSelector(
                            initialBoxDecoration: _boxDecoration,
                            onChangeBoxDecoration: (value) {
                              setState(() {
                                _boxDecoration = value;
                              });
                            },
                          ),
                        ),
                        spacer,
                        spacer,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
