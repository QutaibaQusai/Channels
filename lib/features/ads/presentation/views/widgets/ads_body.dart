import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:channels/features/ads/presentation/cubit/ads_state.dart';
import 'package:channels/features/ads/presentation/views/widgets/ads_success.dart';

class AdsBody extends StatelessWidget {
  const AdsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsCubit, AdsState>(
      builder: (context, state) {
        return switch (state) {
          AdsInitial() => const SizedBox.shrink(),
          AdsLoading() => const AppLoading(),
          AdsSuccess() => AdsSuccessContent(ads: state.ads),
          AdsFailure() => ErrorStateWidget(
            message: state.message,
            onRetry: () => context.read<AdsCubit>().fetchAds(),
          ),
        };
      },
    );
  }
}
