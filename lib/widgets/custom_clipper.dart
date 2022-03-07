import 'package:flutter/material.dart';

class SmallClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(-0.003999999999997783 * _xScaling, 217.841 * _yScaling);
    path.cubicTo(
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
      19.14 * _xScaling,
      265.91999999999996 * _yScaling,
      67.233 * _xScaling,
      265.91999999999996 * _yScaling,
    );
    path.cubicTo(
      115.326 * _xScaling,
      265.91999999999996 * _yScaling,
      112.752 * _xScaling,
      234.611 * _yScaling,
      173.83299999999997 * _xScaling,
      241.635 * _yScaling,
    );
    path.cubicTo(
      234.914 * _xScaling,
      248.659 * _yScaling,
      272.866 * _xScaling,
      301.691 * _yScaling,
      328.608 * _xScaling,
      301.691 * _yScaling,
    );
    path.cubicTo(
      384.34999999999997 * _xScaling,
      301.691 * _yScaling,
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      201.977 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
      -0.003999999999997783 * _xScaling,
      217.841 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BigClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(
        -0.003999999999997783 * _xScaling, 341.78499999999997 * _yScaling);
    path.cubicTo(
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      23.461000000000002 * _xScaling,
      363.15099999999995 * _yScaling,
      71.553 * _xScaling,
      363.15099999999995 * _yScaling,
    );
    path.cubicTo(
      119.645 * _xScaling,
      363.15099999999995 * _yScaling,
      142.21699999999998 * _xScaling,
      300.186 * _yScaling,
      203.29500000000002 * _xScaling,
      307.21 * _yScaling,
    );
    path.cubicTo(
      264.373 * _xScaling,
      314.234 * _yScaling,
      282.666 * _xScaling,
      333.47299999999996 * _yScaling,
      338.408 * _xScaling,
      333.47299999999996 * _yScaling,
    );
    path.cubicTo(
      394.15000000000003 * _xScaling,
      333.47299999999996 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      254.199 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      413.99600000000004 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      413.99600000000004 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      -0.003999999999976467 * _xScaling,
      0 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
      -0.003999999999997783 * _xScaling,
      341.78499999999997 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BezierClipper extends CustomClipper<Path> {
  final double progress;
  BezierClipper(this.progress);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;

  @override
  Path getClip(Size size) {
    Path path = Path();
    final double artboardW = 414 + (0) * progress;
    final double artboardH = 363.15 + (-61.45999999999998) * progress;
    final double _xScaling = size.width / artboardW;
    final double _yScaling = size.height / artboardH;
    path.lineTo((0 + (0) * progress) * _xScaling,
        (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling);
    path.cubicTo(
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
      (23.465 + (-4.3210000000000015) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
      (71.55699999999999 + (-4.319999999999993) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
    );
    path.cubicTo(
      (119.649 + (-4.319000000000017) * progress) * _xScaling,
      (363.15099999999995 + (-97.231) * progress) * _yScaling,
      (142.221 + (-29.465000000000003) * progress) * _xScaling,
      (300.186 + (-65.57499999999999) * progress) * _yScaling,
      (203.299 + (-29.462000000000018) * progress) * _xScaling,
      (307.21 + (-65.57499999999999) * progress) * _yScaling,
    );
    path.cubicTo(
      (264.377 + (-29.45900000000003) * progress) * _xScaling,
      (314.234 + (-65.57499999999999) * progress) * _yScaling,
      (282.66999999999996 + (-9.799999999999955) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
      (338.412 + (-9.800000000000011) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
    );
    path.cubicTo(
      (394.154 + (-9.800000000000068) * progress) * _xScaling,
      (333.47299999999996 + (-31.781999999999982) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
    );
    path.cubicTo(
      (414 + (0) * progress) * _xScaling,
      (254.199 + (-52.22200000000001) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
    );
    path.cubicTo(
      (414 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
    );
    path.cubicTo(
      (2.1316282072803006e-14 + (0) * progress) * _xScaling,
      (0 + (0) * progress) * _yScaling,
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
      (0 + (0) * progress) * _xScaling,
      (341.78499999999997 + (-123.94399999999996) * progress) * _yScaling,
    );
    return path;
  }
}
