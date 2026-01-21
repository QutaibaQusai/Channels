// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commonNext => 'التالي';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonGetStarted => 'ابدأ الآن';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDone => 'تم';

  @override
  String get countryPickerTitle => 'اختر الدولة';

  @override
  String get countryPickerSearchHint => 'ابحث عن دولة...';

  @override
  String get countryPickerNoResults => 'لم يتم العثور على دول';

  @override
  String get countryPickerError => 'فشل تحميل الدول';

  @override
  String get countryPickerLoading => 'جاري تحميل الدول...';

  @override
  String get phoneAuthTitle => 'أدخل رقم هاتفك';

  @override
  String get phoneAuthSubtitle => 'سنرسل لك رمز تحقق لتأكيد رقمك';

  @override
  String get phoneAuthSendButton => 'إرسال رمز التحقق';

  @override
  String get phoneAuthErrorEmpty => 'الرجاء إدخال رقم هاتفك';

  @override
  String get phoneAuthErrorInvalid => 'الرجاء إدخال رقم هاتف صحيح';

  @override
  String get phoneAuthOtpSent => 'تم إرسال رمز التحقق بنجاح!';

  @override
  String get otpVerificationTitle => 'تحقق من رقمك';

  @override
  String get otpVerificationSubtitle => 'أدخل الرمز المرسل إلى';

  @override
  String get otpVerificationVerifyButton => 'تحقق';

  @override
  String get otpVerificationResendCode => 'إعادة إرسال الرمز';

  @override
  String otpVerificationResendTimer(int seconds) {
    return 'إعادة الإرسال بعد $seconds ثانية';
  }

  @override
  String get otpVerificationErrorIncomplete => 'الرجاء إدخال الرمز كاملاً';

  @override
  String get otpVerificationVerified => 'تم التحقق من رقم الهاتف بنجاح!';

  @override
  String get otpVerificationOtpResent => 'تم إعادة إرسال الرمز بنجاح!';

  @override
  String get registerTitle => 'أكمل ملفك الشخصي';

  @override
  String get registerSubtitle => 'أخبرنا قليلاً عن نفسك';

  @override
  String get registerNameLabel => 'الاسم';

  @override
  String get registerNamePlaceholder => 'أدخل اسمك';

  @override
  String get registerNameRequired => 'الاسم مطلوب';

  @override
  String get registerDateOfBirthLabel => 'تاريخ الميلاد';

  @override
  String get registerDateOfBirthPlaceholder => 'اختر تاريخ ميلادك';

  @override
  String get registerDateOfBirthRequired => 'تاريخ الميلاد مطلوب';

  @override
  String get registerButton => 'إكمال التسجيل';

  @override
  String get onboardingPage1Title => 'قناتك الشخصية للإعلانات';

  @override
  String get onboardingPage1Subtitle =>
      'اشترك في الفئات التي تهمك واحصل على إشعارات فورية للإعلانات الجديدة';

  @override
  String get onboardingPage2Title => 'أنشئ قنوات، ابقَ على اطلاع';

  @override
  String get onboardingPage2Subtitle =>
      'اختر فئاتك المفضلة وحدد الفلاتر لتستقبل فقط الإعلانات التي تهمك';

  @override
  String get onboardingPage3Title => 'انشر إعلانات في ثوانٍ';

  @override
  String get onboardingPage3Subtitle =>
      'التقط بعض الصور، أضف التفاصيل، وتواصل مع آلاف المشترين المحتملين فوراً';
}
