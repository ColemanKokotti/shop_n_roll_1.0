import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/receipt_screen.dart';
import '../Providers/all_items_bought_provider.dart';

class TotalPriceBottomBar extends StatelessWidget {
  const TotalPriceBottomBar({super.key});

  Stream<double> _totalPriceStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value(0.0);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      double totalPrice = 0.0;

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data();

        // Get the unit price
        double unitPrice = data['unitPrice'] is double
            ? data['unitPrice']
            : double.tryParse(data['unitPrice']?.toString() ?? '0.0') ?? 0.0;

        // Get the quantity
        int quantity = data['quantity'] is int
            ? data['quantity']
            : int.tryParse(data['quantity']?.toString() ?? '0') ?? 0;

        // Calculate the item's total price and add to the sum
        totalPrice += (unitPrice * quantity);
      }

      return totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<double>(
      stream: _totalPriceStream(),
      builder: (context, priceSnapshot) {
        if (priceSnapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (priceSnapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Error'.tr(),
                style: TextStyle(
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        final totalPrice = priceSnapshot.data ?? 0.0;

        return StreamBuilder<bool>(
          stream: AllItemsBoughtProvider.allItemsBoughtStream(),
          builder: (context, allBoughtSnapshot) {
            final allItemsBought = allBoughtSnapshot.data ?? false;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total'.tr(),
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontSize: 16,
                    ),
                  ),

                      if (allItemsBought && allBoughtSnapshot.data != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReceiptScreen(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.receipt_long,
                              color: theme.iconTheme.color,
                            ),
                            label: Text(
                              'Receipt'.tr(),
                              style: TextStyle(
                                color: theme.textTheme.bodyMedium?.color,
                                fontSize: 15,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.appBarTheme.foregroundColor,
                              foregroundColor: theme.appBarTheme.backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      Text(
                        '${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: theme.textTheme.bodyLarge?.color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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