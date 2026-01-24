import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Toast type enum for different toast styles
enum AppToastType { success, error, info }

/// Beautiful top-positioned toast notification widget
/// Use AppToast.show() to display a toast
class AppToast {
  AppToast._();

  /// Show a success toast
  static void success(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(
      context,
      type: AppToastType.success,
      title: title,
      duration: duration,
    );
  }

  /// Show an error toast
  static void error(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(context, type: AppToastType.error, title: title, duration: duration);
  }

  /// Show an info toast
  static void info(
    BuildContext context, {
    required String title,
    Duration duration = const Duration(seconds: 4),
  }) {
    _show(context, type: AppToastType.info, title: title, duration: duration);
  }

  /// Internal show method
  static void _show(
    BuildContext context, {
    required AppToastType type,
    required String title,
    required Duration duration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        type: type,
        title: title,
        onDismiss: () => overlayEntry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);
  }
}

/// Internal toast widget with animations
class _ToastWidget extends StatefulWidget {
  final AppToastType type;
  final String title;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.type,
    required this.title,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    // Auto dismiss after duration
    Future.delayed(widget.duration, () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: AppSizes.screenPaddingH,
      right: AppSizes.screenPaddingH,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy < 0) {
                  _dismiss();
                }
              },
              child: _ToastContent(type: widget.type, title: widget.title),
            ),
          ),
        ),
      ),
    );
  }
}

/// Toast content widget with proper styling
class _ToastContent extends StatelessWidget {
  final AppToastType type;
  final String title;

  const _ToastContent({required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(type);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.r16),
        border: Border.all(color: colors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: colors.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(colors.icon, color: colors.iconColor, size: 20.sp),
          ),

          SizedBox(width: 12.w),

          // Text content
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colors.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _ToastColors _getColors(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return _ToastColors(
          backgroundColor: const Color(0xFF1A3D2A),
          borderColor: const Color(0xFF2D5A3D),
          iconBackgroundColor: const Color(0xFF22C55E),
          iconColor: Colors.white,
          icon: LucideIcons.check,
          textColor: Colors.white,
          buttonColor: const Color(0xFF2D5A3D),
          buttonTextColor: Colors.white,
        );
      case AppToastType.error:
        return _ToastColors(
          backgroundColor: const Color(0xFF3D1A1A),
          borderColor: const Color(0xFF5A2D2D),
          iconBackgroundColor: const Color(0xFFEF4444),
          iconColor: Colors.white,
          icon: LucideIcons.alertCircle,
          textColor: Colors.white,
          buttonColor: const Color(0xFF5A2D2D),
          buttonTextColor: Colors.white,
        );
      case AppToastType.info:
        return _ToastColors(
          backgroundColor: const Color(0xFF1F2937),
          borderColor: const Color(0xFF374151),
          iconBackgroundColor: const Color(0xFF374151),
          iconColor: Colors.white,
          icon: LucideIcons.atSign,
          textColor: Colors.white,
          buttonColor: const Color(0xFF374151),
          buttonTextColor: Colors.white,
        );
    }
  }
}

/// Toast colors configuration
class _ToastColors {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;

  const _ToastColors({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.icon,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
  });
}
