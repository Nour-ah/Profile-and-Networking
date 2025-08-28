// presentation/widgets/gradient_button.dart
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final bool isLoading;
  final IconData? icon;

  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [const Color(0xFF667eea), const Color(0xFF764ba2)];

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: isOutlined ? null : LinearGradient(colors: colors),
        border: isOutlined ? Border.all(color: colors.first, width: 2) : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isOutlined
            ? null
            : [
                BoxShadow(
                  color: colors.first.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: isOutlined ? colors.first : Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isOutlined ? colors.first : Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
