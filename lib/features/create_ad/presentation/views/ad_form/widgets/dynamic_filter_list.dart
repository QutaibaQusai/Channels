import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';
import 'package:channels/features/create_ad/presentation/views/ad_form/widgets/select_filter_field.dart';
import 'package:channels/features/create_ad/presentation/views/ad_form/widgets/text_filter_field.dart';

/// Displays dynamic filters and common ad fields (title, description, price)
class DynamicFilterList extends StatefulWidget {
  final List<Filter> filters;
  final String categoryId;

  const DynamicFilterList({
    super.key,
    required this.filters,
    required this.categoryId,
  });

  @override
  State<DynamicFilterList> createState() => _DynamicFilterListState();
}

class _DynamicFilterListState extends State<DynamicFilterList> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
        children: [
          // Dynamic filters based on category
          ...widget.filters.map((filter) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppSizes.s16),
              child: _buildFilterField(filter),
            );
          }),

          SizedBox(height: AppSizes.s24),

          // Submit button
          AppButton(
            text: 'Submit Ad',
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterField(Filter filter) {
    switch (filter.type) {
      case 'select':
        return SelectFilterField(
          filter: filter,
          onChanged: (value) {
            setState(() {
              _formData[filter.key] = value;
            });
          },
        );
      case 'text':
        return TextFilterField(
          filter: filter,
          onChanged: (value) {
            setState(() {
              _formData[filter.key] = value;
            });
          },
        );
      default:
        return TextFilterField(
          filter: filter,
          onChanged: (value) {
            setState(() {
              _formData[filter.key] = value;
            });
          },
        );
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint('Form data: $_formData');
      debugPrint('Category ID: ${widget.categoryId}');
      // TODO: Implement ad submission
    }
  }
}
