import 'package:flutter/material.dart';

/// Spacing helper functions for consistent gaps between widgets
/// Use these instead of SizedBox for cleaner code

/// Creates vertical spacing (height gap)
/// Example: verticalSpace(AppSizes.s16)
SizedBox verticalSpace(double height) => SizedBox(height: height);

/// Creates horizontal spacing (width gap)
/// Example: horizontalSpace(AppSizes.s16)
SizedBox horizontalSpace(double width) => SizedBox(width: width);
