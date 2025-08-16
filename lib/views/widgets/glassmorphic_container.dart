// lib/views/widgets/glassmorphic_container.dart

import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isCircle;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final boxShape = isCircle ? BoxShape.circle : BoxShape.rectangle;
    final borderRadius = isCircle ? null : BorderRadius.circular(15);

    // BUG FIX: Wrapping in a Material widget ensures correct layout behavior
    // inside specific Scaffold slots like bottomNavigationBar.
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            margin: margin,
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: boxShape,
              borderRadius: borderRadius,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}