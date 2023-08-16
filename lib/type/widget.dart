import 'package:flutter/material.dart';

abstract class WidgetWithTitle extends StatefulWidget {
  final String title;
  const WidgetWithTitle({super.key, required this.title});
}
