import 'package:intl/intl.dart';

/// Formatting utilities for dates, numbers, and strings
class Formatters {
  Formatters._();

  // ==================== DATE FORMATTING ====================

  /// Format date as "Jan 15, 2024"
  static String date(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format date as "January 15, 2024"
  static String dateFull(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Format time as "3:45 PM"
  static String time(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }

  /// Format date and time as "Jan 15, 2024 at 3:45 PM"
  static String dateTime(DateTime date) {
    return '${DateFormat('MMM dd, yyyy').format(date)} at ${DateFormat('h:mm a').format(date)}';
  }

  /// Get relative time (e.g., "2 hours ago", "Just now")
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  // ==================== NUMBER FORMATTING ====================

  /// Format number with commas (e.g., 1,234,567)
  static String number(num value) {
    return NumberFormat('#,##0').format(value);
  }

  /// Format currency (e.g., $1,234.56)
  static String currency(num value, {String symbol = '\$'}) {
    return '$symbol${NumberFormat('#,##0.00').format(value)}';
  }

  /// Format percentage (e.g., 45.5%)
  static String percentage(num value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }

  /// Format file size (e.g., 1.5 MB)
  static String fileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  // ==================== STRING FORMATTING ====================

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Title case (capitalize each word)
  static String titleCase(String text) {
    return text.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Format phone number (e.g., "(555) 123-4567")
  static String phoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }
    return phone;
  }
}
