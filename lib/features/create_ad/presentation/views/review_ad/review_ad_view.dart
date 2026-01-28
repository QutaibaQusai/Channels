import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_cubit.dart';
import 'package:channels/features/create_ad/presentation/cubit/create_ad/create_ad_state.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/modern_image_gallery.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/title_price_section.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/quick_info_tags.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/description_section.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/specifications_section.dart';
import 'package:channels/features/create_ad/presentation/views/review_ad/widgets/review_notice_card.dart';

class CreateAdReviewView extends StatelessWidget {
  final Map<String, dynamic> formData;
  final Map<String, String> displayData;
  final String categoryId;
  final String parentCategoryId;
  final String rootCategoryId;
  final List<File> images;
  final String title;
  final String description;
  final double price;
  final String countryCode;

  const CreateAdReviewView({
    super.key,
    required this.formData,
    required this.displayData,
    required this.categoryId,
    required this.parentCategoryId,
    required this.rootCategoryId,
    required this.images,
    required this.title,
    required this.description,
    required this.price,
    required this.countryCode,
  });

  void _handlePublish(BuildContext context, CreateAdState state) {
    if (state is CreateAdLoading) return;

    context.read<CreateAdCubit>().createAd(
      categoryId: rootCategoryId,
      subcategoryId: categoryId,
      countryCode: countryCode,
      title: title,
      description: description,
      price: price,
      images: images,
      attributes: formData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return BlocProvider(
      create: (context) => CreateAdCubit(createAdUseCase: sl()),
      child: BlocConsumer<CreateAdCubit, CreateAdState>(
        listener: (context, state) {
          if (state is CreateAdSuccess) {
            AppToast.success(context, title: 'Ad published successfully!');
            context.go('/home');
          } else if (state is CreateAdFailure) {
            AppToast.error(context, title: state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateAdLoading;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: const AppAppBar(
              title: 'Review Your Ad',
              showBackButton: true,
            ),
            body: SafeArea(
              bottom: false,
              child: GradientOverlay(
                bottomWidget: Padding(
                  padding: EdgeInsets.all(AppSizes.s16),
                  child: AppButton(
                    text: isLoading ? 'Publishing...' : 'Publish Ad',
                    onPressed: () => _handlePublish(context, state),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Image Gallery Section
                    ModernImageGallery(images: images),

                    Padding(
                      padding: EdgeInsets.all(AppSizes.s16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Price Section
                          TitlePriceSection(
                            title: title,
                            price: price,
                            colorScheme: colorScheme,
                          ),

                          verticalSpace(AppSizes.s16),

                          // Quick Info Tags
                          QuickInfoTags(
                            countryCode: countryCode,
                            colorScheme: colorScheme,
                          ),

                          verticalSpace(AppSizes.s24),

                          // Description Section
                          DescriptionSection(
                            description: description,
                            colorScheme: colorScheme,
                            textExtension: textExtension,
                          ),

                          // Specifications Section
                          if (displayData.isNotEmpty) ...[
                            verticalSpace(AppSizes.s24),
                            SpecificationsSection(
                              displayData: displayData,
                              colorScheme: colorScheme,
                              textExtension: textExtension,
                            ),
                          ],

                          verticalSpace(AppSizes.s24),

                          // Review Notice Card
                          ReviewNoticeCard(
                            colorScheme: colorScheme,
                            textExtension: textExtension,
                          ),

                          verticalSpace(AppSizes.s80), // Space for button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
