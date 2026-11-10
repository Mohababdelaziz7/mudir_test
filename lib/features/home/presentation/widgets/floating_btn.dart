import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatingBtn extends StatelessWidget {
  final String iconImg;
  final Color color;
  final Color shadColor;
  final List<Color> colors;
  final VoidCallback? onPressed;

  const FloatingBtn({
    super.key,
    required this.iconImg,
    required this.color,
    required this.shadColor,
    required this.colors,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed ?? () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: color,
      elevation: 0,
      child: Container(
        width: 56,
        height: 56,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.19, 0.04),
            end: const Alignment(0.84, 0.96),
            colors: colors,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          shadows: [
            BoxShadow(
              color: shadColor.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(8, 8),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: SizedBox(
            width: 28,
            height: 28,
            child: SvgPicture.asset(
              iconImg,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
