import 'dart:math';

import 'package:flutter/material.dart';

class SliderColorSelector extends StatelessWidget {
  const SliderColorSelector({
    super.key,
    required this.initialColor,
    required this.onChangeColor,
    this.dimensionOfBoxes = 25,
  });

  final Color initialColor;
  final Function(Color) onChangeColor;
  final double dimensionOfBoxes;

  BoxDecoration _boxDecoration(
    Color color,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Slider para seleccionar el color rojo
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  decoration: _boxDecoration(Colors.black),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
                Expanded(
                  child: Slider(
                      value: initialColor.red.toDouble(),
                      min: 0,
                      max: 255,
                      onChanged: (value) {
                        onChangeColor(
                          Color.fromARGB(
                            255,
                            value.toInt(),
                            initialColor.green,
                            initialColor.blue,
                          ),
                        );
                      }),
                ),
                Container(
                  decoration: _boxDecoration(Colors.red),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
              ],
            ),
          ),
        ),
        // Slider para seleccionar el color verde
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  decoration: _boxDecoration(Colors.black),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
                Expanded(
                  child: Slider(
                    value: initialColor.green.toDouble(),
                    min: 0,
                    max: 255,
                    onChanged: (value) {
                      onChangeColor(
                        Color.fromARGB(
                          255,
                          initialColor.red,
                          value.toInt(),
                          initialColor.blue,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: _boxDecoration(Colors.green),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
              ],
            ),
          ),
        ),
        // Slider para seleccionar el color azul
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  decoration: _boxDecoration(Colors.black),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
                Expanded(
                  child: Slider(
                    value: initialColor.blue.toDouble(),
                    min: 0,
                    max: 255,
                    onChanged: (value) {
                      onChangeColor(
                        Color.fromARGB(
                          255,
                          initialColor.red,
                          initialColor.green,
                          value.toInt(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: _boxDecoration(Colors.blue),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
              ],
            ),
          ),
        ),
        // Slider para seleccionar la opacidad
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  decoration: _boxDecoration(Colors.black),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
                Expanded(
                  child: Slider(
                    value: initialColor.alpha.toDouble(),
                    min: 0,
                    max: 255,
                    onChanged: (value) {
                      onChangeColor(
                        Color.fromARGB(
                          value.toInt(),
                          initialColor.red,
                          initialColor.green,
                          initialColor.blue,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: _boxDecoration(Colors.white),
                  width: dimensionOfBoxes,
                  height: dimensionOfBoxes,
                ),
              ],
            ),
          ),
        ),
        // Row con 4 botones para seleccionar colores; rojo, verde, azul, random.
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    if (!(initialColor == Colors.red)) {
                      onChangeColor(Colors.red);
                    }
                  },
                  child: Container(
                    decoration: _boxDecoration(Colors.red),
                    child: const Center(
                      child: Text('Rojo'),
                    ),
                  ),
                )),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!(initialColor == Colors.green)) {
                        onChangeColor(Colors.green);
                      }
                    },
                    child: Container(
                      decoration: _boxDecoration(Colors.green),
                      child: const Center(
                        child: Text('Verde'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!(initialColor == Colors.blue)) {
                        onChangeColor(Colors.blue);
                      }
                    },
                    child: Container(
                      decoration: _boxDecoration(Colors.blue),
                      child: const Center(
                        child: Text('Azul'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      final random = Random();
                      onChangeColor(
                        Color.fromARGB(
                          255,
                          random.nextInt(255),
                          random.nextInt(255),
                          random.nextInt(255),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.green,
                            Colors.blue,
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text('Random'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
