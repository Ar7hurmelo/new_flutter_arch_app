import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor:
              backgroundColor ?? Theme.of(context).colorScheme.primary,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
