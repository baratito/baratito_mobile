import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:baratito_mobile/ui/home/library/summaries/summary_tabs.dart';

class PurchaseSummaries extends StatelessWidget {
  final MonthlyPurchaseSummariesCubit summariesCubit;

  const PurchaseSummaries({
    Key? key,
    required this.summariesCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyPurchaseSummariesCubit,
        MonthlyPurchaseSummariesState>(
      bloc: summariesCubit,
      builder: (context, state) {
        if (state is MonthlyPurchaseSummariesLoading) {
          return _buildLoading(context);
        }
        if (state is MonthlyPurchaseSummariesLoaded) {
          return _buildContent(context, state);
        }
        return Container();
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Spinner()],
    );
  }

  Widget _buildContent(
    BuildContext context,
    MonthlyPurchaseSummariesLoaded state,
  ) {
    final summaries = state.summaries;
    return SummaryTabs(
      summaries: summaries,
      onRefresh: () => summariesCubit.get(),
    );
  }
}
