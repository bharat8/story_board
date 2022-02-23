import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  final BoxConstraints constraints;
  const AppBarBackButton({Key? key, required this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => Navigator.of(context).pop(),
      child: Row(
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.04,
            child: const FittedBox(
              child: Icon(Icons.arrow_back_ios),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          Text(
            "Back",
            style: TextStyle(fontSize: constraints.maxHeight * 0.02),
          ),
        ],
      ),
    );
  }
}
