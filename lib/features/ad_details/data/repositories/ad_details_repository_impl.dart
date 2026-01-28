import 'package:channels/core/errors/exceptions.dart';
import 'package:channels/core/errors/failures.dart';
import 'package:channels/features/ad_details/data/data_sources/ad_details_remote_data_source.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/features/ad_details/domain/repositories/ad_details_repository.dart';

class AdDetailsRepositoryImpl implements AdDetailsRepository {
  final AdDetailsRemoteDataSource remoteDataSource;

  AdDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AdDetails> getAdDetails({
    required String adId,
    required String languageCode,
  }) async {
    try {
      return await remoteDataSource.getAdDetails(
        adId: adId,
        languageCode: languageCode,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.errModel.errorMessage);
    }
  }
}
