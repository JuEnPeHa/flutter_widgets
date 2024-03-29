import 'package:flutter/material.dart';

final Border noBorder = Border.all(
  color: Colors.transparent,
);

final Border border = Border.all(
  color: Colors.black,
  width: 5,
);

class BoxDecorationSelector extends StatelessWidget {
  const BoxDecorationSelector({
    super.key,
    required this.initialBoxDecoration,
    required this.onChangeBoxDecoration,
  });

  final BoxDecoration initialBoxDecoration;
  final Function(BoxDecoration) onChangeBoxDecoration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: initialBoxDecoration.border == noBorder
                ? () {
                    onChangeBoxDecoration(
                      initialBoxDecoration.copyWith(
                        border: border,
                      ),
                    );
                  }
                : () {
                    onChangeBoxDecoration(
                      initialBoxDecoration.copyWith(
                        border: noBorder,
                      ),
                    );
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: initialBoxDecoration.border != null
                    ? Colors.black
                    : Colors.white,
              ),
              child: Center(
                child: Text(
                  'Borde',
                  style: TextStyle(
                      color: initialBoxDecoration.border != null
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: initialBoxDecoration.borderRadius == BorderRadius.zero
                ? () {
                    onChangeBoxDecoration(
                      initialBoxDecoration.copyWith(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  }
                : () {
                    onChangeBoxDecoration(
                      initialBoxDecoration.copyWith(
                        borderRadius: BorderRadius.zero,
                      ),
                    );
                  },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: initialBoxDecoration.borderRadius != null
                    ? Colors.black
                    : Colors.white,
              ),
              child: Center(
                child: Text(
                  'Esquina',
                  style: TextStyle(
                      color: initialBoxDecoration.borderRadius != null
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
