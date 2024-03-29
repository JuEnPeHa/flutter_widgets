import 'package:flutter/material.dart';

class SliderSizeSelector extends StatelessWidget {
  const SliderSizeSelector({
    super.key,
    required this.initialSize,
    required this.onChangeSize,
    required this.maxSize,
  });

  final Size initialSize;
  final Function(Size) onChangeSize;
  final Size maxSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Text('Ancho: '),
                Expanded(
                  child: Slider(
                    value: initialSize.width,
                    min: 0,
                    max: maxSize.width,
                    onChanged: (value) {
                      onChangeSize(Size(value, initialSize.height));
                    },
                  ),
                ),
                Text('${initialSize.width.toInt()}'),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Text('Alto: '),
                Expanded(
                  child: Slider(
                    value: initialSize.height,
                    min: 0,
                    max: maxSize.height,
                    onChanged: (value) {
                      onChangeSize(Size(initialSize.width, value));
                    },
                  ),
                ),
                Text('${initialSize.height.toInt()}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
