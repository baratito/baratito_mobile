import 'package:baratito_core/baratito_core.dart';
import 'package:baratito_mobile/ui/shopping/shopping_list_detail/shopping_list_item_detail_tile.dart';
import 'package:baratito_ui/baratito_ui.dart';
import 'package:flutter/material.dart';

import 'package:baratito_mobile/extensions/extensions.dart';

class ShoppingListDetailItemList extends StatelessWidget {
  final bool isLoading;
  final List<ShoppingListItem>? items;

  const ShoppingListDetailItemList({
    Key? key,
    this.items,
    this.isLoading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading && items == null) return Container();
    if (items != null && items!.isEmpty) return Container();
    return LoadingCrossfade(
      isLoading: isLoading,
      loadingWidget: _buildSkeleton(context),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (items == null) return Container();
    return ListView.builder(
      itemCount: items!.length,
      itemBuilder: (_, index) {
        final item = items![index];
        return _buildTile(context, item);
      },
    );
  }

  Widget _buildTile(BuildContext context, ShoppingListItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.responsive(16)),
      child: ShoppingListItemDetailTile(item: item),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final _ in Iterable.generate(6))
          Padding(
            padding: EdgeInsets.only(top: context.responsive(16)),
            child: Row(
              children: [
                PulseBox.square(
                  dimension: context.theme.dimensions.squircleContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: context.responsive(12, axis: Axis.horizontal),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PulseBox(height: 16, width: 160),
                      PulseBox(
                        height: 14,
                        width: 80,
                        margin: EdgeInsets.only(top: context.responsive(12)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
