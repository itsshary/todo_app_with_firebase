import 'package:flutter/material.dart';

class ComponetButton extends StatelessWidget {
  final String text;
  final VoidCallback onpress;
  const ComponetButton({super.key, required this.text, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onpress,
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
