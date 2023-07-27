import 'package:flutter/material.dart';

class TabItem {
  final String iconPath;
  final String? title;
  final Widget? count;
  final String? key;

  const TabItem({
    required this.iconPath,
    this.title,
    this.count,
    this.key,
  }) ;
}
