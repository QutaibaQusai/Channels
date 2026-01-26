import 'package:flutter/material.dart';

/// A reusable widget that places a bottom gradient overlay on top of [child]
/// and shows a fixed [bottomWidget] above it.
///
/// Creates a smooth gradient fade effect from transparent to the scaffold background color.
/// Perfect for floating action buttons, bottom navigation, or fixed CTAs.
///
/// - [inverseGradient] = false: transparent (top) -> opaque (bottom) - default
/// - [inverseGradient] = true : opaque (top) -> transparent (bottom)
class GradientOverlay extends StatelessWidget {
  final Widget child;
  final Widget? bottomWidget;
  final bool inverseGradient;

  const GradientOverlay({
    super.key,
    required this.child,
    this.bottomWidget,
    this.inverseGradient = false,
  });

  static const List<double> _stops = <double>[
    0.0,
    0.05,
    0.10,
    0.15,
    0.25,
    0.35,
    0.45,
    0.55,
    0.65,
    0.75,
    0.85,
    0.95,
    1.0,
  ];

  @override
  Widget build(BuildContext context) {
    final Color bg = Theme.of(context).scaffoldBackgroundColor;

    final List<Color> colors = inverseGradient
        ? <Color>[
            bg,
            bg.withValues(alpha: 0.95),
            bg.withValues(alpha: 0.90),
            bg.withValues(alpha: 0.85),
            bg.withValues(alpha: 0.75),
            bg.withValues(alpha: 0.65),
            bg.withValues(alpha: 0.55),
            bg.withValues(alpha: 0.45),
            bg.withValues(alpha: 0.35),
            bg.withValues(alpha: 0.25),
            bg.withValues(alpha: 0.15),
            bg.withValues(alpha: 0.05),
            bg.withValues(alpha: 0.0),
          ]
        : <Color>[
            bg.withValues(alpha: 0.0),
            bg.withValues(alpha: 0.05),
            bg.withValues(alpha: 0.15),
            bg.withValues(alpha: 0.25),
            bg.withValues(alpha: 0.35),
            bg.withValues(alpha: 0.45),
            bg.withValues(alpha: 0.55),
            bg.withValues(alpha: 0.65),
            bg.withValues(alpha: 0.75),
            bg.withValues(alpha: 0.85),
            bg.withValues(alpha: 0.90),
            bg.withValues(alpha: 0.95),
            bg,
          ];

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child,
        if (bottomWidget != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: colors,
                  stops: _stops,
                ),
              ),
              child: SafeArea(top: false, child: bottomWidget!),
            ),
          ),
      ],
    );
  }
}
