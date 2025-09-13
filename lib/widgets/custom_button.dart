// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(isPrimary ? Colors.blueAccent : Colors.white),
          foregroundColor: MaterialStateProperty.all(isPrimary ? Colors.white : Colors.black),
          overlayColor: MaterialStateProperty.all(isPrimary ? Colors.blueAccent.withOpacity(0.8) : Colors.grey.shade200),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
          )),
          elevation: MaterialStateProperty.all(isPrimary ? 2.0 : 0.0),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
