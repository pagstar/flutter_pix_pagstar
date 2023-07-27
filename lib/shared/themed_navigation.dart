import 'package:flutter/material.dart';

import '../flutter_pix_pagstar.dart';

class ThemedNavigation {
  static Future<T?> pushWithTheme<T>(BuildContext context, Widget page) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Theme(
          data: FlutterPixPagstar.theme,
          child: page,
        ),
      ),
    );
  }

  static Future<T?> pushReplacementWithTheme<T>(
      BuildContext context, Widget page) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Theme(
          data: FlutterPixPagstar.theme,
          child: page,
        ),
      ),
    );
  }
}
