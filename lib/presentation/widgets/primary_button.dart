import 'package:flutter/material.dart';
import 'package:verum_agro_trading/theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.height,
    required this.width,
    this.backgroundColor,
    required this.text,
    this.isActive = true,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final double height;
  final double width;
  final Color? backgroundColor;
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            blurRadius: 13.0,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: !isLoading && isActive ? onTap : null,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              // minimumSize: MaterialStatePropertyAll<Size?>(Size(width, height)),
              backgroundColor:
                  MaterialStatePropertyAll<Color?>(backgroundColor),
            ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                )
              : Text(
                  text,
                  style: isActive
                      ? baseTextStyle
                      : baseTextStyle.copyWith(color: offWhite3),
                ),
        ),
      ),
    );
  }
}
