import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:channels/core/api/dio_consumer.dart';
import 'package:channels/core/api/api_consumer.dart';

// Authentication - Data Sources
import 'package:channels/features/authentication/data/data_sources/countries_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/verify_otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/update_preferences_remote_data_source.dart';

// Authentication - Repository
import 'package:channels/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

// Authentication - Use Cases
import 'package:channels/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/get_countries_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/update_preferences_usecase.dart';

// Ads
import 'package:channels/features/ads/data/data_sources/ads_remote_data_source.dart';
import 'package:channels/features/ads/data/repositories/ads_repository_impl.dart';
import 'package:channels/features/ads/domain/repositories/ads_repository.dart';
import 'package:channels/features/ads/domain/usecases/get_category_ads.dart';

// Categories
import 'package:channels/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:channels/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:channels/features/categories/domain/repositories/categories_repository.dart';
import 'package:channels/features/categories/domain/usecases/get_categories.dart';

// Profile
import 'package:channels/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:channels/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:channels/features/profile/domain/repositories/profile_repository.dart';
import 'package:channels/features/profile/domain/usecases/get_profile.dart';
import 'package:channels/features/profile/domain/usecases/update_profile.dart';

// Create Ad
import 'package:channels/features/create_ad/data/data_sources/create_ad_remote_data_source.dart';
import 'package:channels/features/create_ad/data/repositories/create_ad_repository_impl.dart';
import 'package:channels/features/create_ad/domain/repositories/create_ad_repository.dart';
import 'package:channels/features/create_ad/domain/usecases/create_ad.dart';

// My Ads
import 'package:channels/features/my_ads/data/data_sources/my_ads_remote_data_source.dart';
import 'package:channels/features/my_ads/data/repositories/my_ads_repository_impl.dart';
import 'package:channels/features/my_ads/domain/repositories/my_ads_repository.dart';
import 'package:channels/features/my_ads/domain/usecases/get_my_ads.dart';

// Ad Details (Shared)
import 'package:channels/features/ad_details/data/data_sources/ad_details_remote_data_source.dart';
import 'package:channels/features/ad_details/data/repositories/ad_details_repository_impl.dart';
import 'package:channels/features/ad_details/domain/repositories/ad_details_repository.dart';
import 'package:channels/features/ad_details/domain/usecases/get_ad_details.dart';
import 'package:channels/features/ad_details/domain/usecases/delete_ad.dart';
import 'package:channels/features/ad_details/presentation/cubit/ad_details_cubit.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> setupServiceLocator() async {
  // ==================== CORE ====================

  // Dio - Singleton
  sl.registerLazySingleton<Dio>(() => Dio());

  // API Consumer - Singleton
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  // ==================== AUTHENTICATION ====================

  // Data Sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
    () => CountriesRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<VerifyOtpRemoteDataSource>(
    () => VerifyOtpRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<UpdatePreferencesRemoteDataSource>(
    () => UpdatePreferencesRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      otpDataSource: sl(),
      verifyOtpDataSource: sl(),
      countriesDataSource: sl(),
      updatePreferencesDataSource: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<RequestOtpUseCase>(() => RequestOtpUseCase(sl()));

  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));

  sl.registerLazySingleton<GetCountriesUseCase>(
    () => GetCountriesUseCase(sl()),
  );

  sl.registerLazySingleton<UpdatePreferencesUseCase>(
    () => UpdatePreferencesUseCase(sl()),
  );

  // ==================== ADS ====================

  sl.registerLazySingleton<AdsRemoteDataSource>(
    () => AdsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<AdsRepository>(
    () => AdsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetCategoryAds>(() => GetCategoryAds(sl()));

  // sl.registerLazySingleton<GetAdDetails>(() => GetAdDetails(sl())); // Moved to Shared

  // ==================== CATEGORIES ====================

  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetCategories>(() => GetCategories(sl()));

  // ==================== PROFILE ====================

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetProfile>(() => GetProfile(sl()));

  sl.registerLazySingleton<UpdateProfile>(
    () => UpdateProfile(repository: sl()),
  );

  // ==================== CREATE AD ====================

  sl.registerLazySingleton<CreateAdRemoteDataSource>(
    () => CreateAdRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<CreateAdRepository>(
    () => CreateAdRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<CreateAd>(() => CreateAd(sl()));

  // ==================== MY ADS ====================

  sl.registerLazySingleton<MyAdsRemoteDataSource>(
    () => MyAdsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<MyAdsRepository>(
    () => MyAdsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetMyAds>(() => GetMyAds(sl()));

  // ==================== AD DETAILS (SHARED) ====================

  sl.registerLazySingleton<AdDetailsRemoteDataSource>(
    () => AdDetailsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<AdDetailsRepository>(
    () => AdDetailsRepositoryImpl(remoteDataSource: sl()),
  );

  // Note: Overwriting previous GetAdDetails registration from Ads feature
  // We should eventually remove the old one.
  sl.registerLazySingleton<GetAdDetails>(() => GetAdDetails(sl()));

  sl.registerLazySingleton<DeleteAd>(() => DeleteAd(repository: sl()));

  sl.registerFactory<AdDetailsCubit>(
    () => AdDetailsCubit(getAdDetailsUseCase: sl(), deleteAdUseCase: sl()),
  );
}
