import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.onTap,
    required this.constraints,
    required this.icon,
  }) : super(key: key);

  final Function onTap;
  final BoxConstraints constraints;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: constraints.maxWidth * 0.08,
        height: constraints.maxHeight,
        margin: EdgeInsets.only(right: constraints.maxWidth * 0.05),
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
        child: FittedBox(
          child: Icon(
            icon,
            color: Colors.black.withOpacity(0.7),
          ),
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
