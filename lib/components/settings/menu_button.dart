import 'package:flutter/material.dart';

class SettingsMenuButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const SettingsMenuButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        minimumSize: const Size.fromHeight(0.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16.0,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
