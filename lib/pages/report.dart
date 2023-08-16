import 'package:fease/type/widget.dart';
import 'package:flutter/material.dart';

class Report extends WidgetWithTitle {
  const Report({super.key}) : super(title: "Report");

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return const Text("Report");
  }
}