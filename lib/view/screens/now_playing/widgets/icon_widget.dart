// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class IconAppBar extends StatelessWidget {
  Function() fnctn;

  final IconData icon;
  IconAppBar({
    Key? key,
    required this.fnctn,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: fnctn,
      icon: Icon(
        icon,
        size: 30,
      ),
      color: Colors.black,
    );
  }
}
