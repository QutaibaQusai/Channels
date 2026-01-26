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
  String get categoriesSearchHint => 'ابحث عن الفئات';

  @override
  String get categoriesSectionTitle => 'الفئات';

  @override
  String get categoriesSeeMore => 'المزيد';

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
  String get registerCountryLabel => 'الدولة';

  @override
  String get registerCountryPlaceholder => 'اختر دولتك';

  @override
  String get registerCountryRequired => 'الدولة مطلوبة';

  @override
  String get registerCountryHint => 'اختر الدولة التي تريد تصفح الإعلانات منها';

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

  @override
  String get layoutBroadcastsTitle => 'البث';

  @override
  String get layoutCategoriesTitle => 'الفئات';

  @override
  String get layoutAiTitle => 'المساعد الذكي';

  @override
  String get adDetailsTitle => 'تفاصيل الإعلان';

  @override
  String get adDetailsAttributes => 'المواصفات';

  @override
  String get adDetailsCall => 'اتصال';

  @override
  String get adDetailsWhatsApp => 'واتساب';

  @override
  String get profileTitle => 'الحساب';

  @override
  String get profileStatusActive => 'نشط';

  @override
  String get profileStatusInactive => 'غير نشط';

  @override
  String get profileCountry => 'الدولة';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileDateOfBirth => 'تاريخ الميلاد';

  @override
  String get profileMemberSince => 'عضو منذ';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsThemeSystem => 'النظام الافتراضي';

  @override
  String get settingsThemeLight => 'الوضع الفاتح';

  @override
  String get settingsThemeDark => 'الوضع الداكن';

  @override
  String get settingsMyAds => 'إعلاناتي';

  @override
  String get settingsDoNotDisturb => 'لا تنبهني';

  @override
  String get settingsDoNotDisturbSubtitle =>
      'فعّل لتحصل على فترة هدوء من الإشعارات';

  @override
  String get settingsHelpCenter => 'مركز المساعدة';

  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get settingsTermsOfService => 'شروط الخدمة';

  @override
  String get settingsSignOut => 'سجّل خروجك';

  @override
  String get profileEditTitle => 'بيانات التعريف';

  @override
  String get profileEditName => 'الاسم';

  @override
  String get profileEditPhone => 'رقم تلفونك';

  @override
  String get profileEditContactSupportPhone =>
      'تواصل مع الدعم لتغيير رقم تلفونك';

  @override
  String get profileEditSave => 'احفظ';

  @override
  String get profileEditDeleteAccount => 'حذف الحساب';

  @override
  String get profileEditUpdateSuccess => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get profileEditUpdateError => 'فشل تحديث الملف الشخصي';

  @override
  String get logoutTitle => 'خروج';

  @override
  String get logoutConfirmation => 'هل تودّ الخروج من هذا الجهاز؟';

  @override
  String get logoutButton => 'خروج';

  @override
  String get logoutCancel => 'تراجع';

  @override
  String get deleteAccountTitle => 'حذف الحساب';

  @override
  String get deleteAccountConfirmation =>
      'هل أنت متأكد أنك تريد حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteAccountButton => 'حذف';

  @override
  String get announcementBannerMessage =>
      'انشر إعلانك مجاناً! وصل لآلاف المشترين اليوم.';

  @override
  String get featuredAdsLabel => 'الإعلانات المميزة';
}
