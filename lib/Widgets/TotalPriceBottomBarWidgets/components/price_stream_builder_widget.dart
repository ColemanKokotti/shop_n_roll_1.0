import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_roll/Widgets/TotalPriceBottomBarWidgets/components/receipt_button_widget.dart';
import 'package:shop_n_roll/Widgets/TotalPriceBottomBarWidgets/components/total_price_display_widget.dart';
import '../../../FireBase/bought_item_provider.dart';
import 'bottom_bar_container_widget.dart';
import 'error_container_widget.dart';
import 'loading_container_widget.dart';


class PriceStreamBuilder extends StatelessWidget {
  final Stream<double> priceStream;
  final ThemeData theme;

  const PriceStreamBuilder({
    super.key,
    required this.priceStream,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: priceStream,
      builder: (context, priceSnapshot) {
        if (priceSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingContainer(theme: theme);
        }

        if (priceSnapshot.hasError) {
          return ErrorContainer(theme: theme);
        }

        final totalPrice = priceSnapshot.data ?? 0.0;

        return StreamBuilder<bool>(
          stream: BoughtItemProvider.anyItemsBoughtStream(),
          builder: (context, anyBoughtSnapshot) {
            final anyItemsBought = anyBoughtSnapshot.data ?? false;

            return BottomBarContainer(
              theme: theme,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total'.tr(),
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontSize: 16,
                        ),
                      ),
                      TotalPriceDisplay(totalPrice: totalPrice, theme: theme),
                    ],
                  ),

                  if (anyItemsBought && anyBoughtSnapshot.data != null)
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: ReceiptButton(),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}