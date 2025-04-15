import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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

        if (snapshot.hasError) {
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

        final totalPrice = snapshot.data ?? 0.0;

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
  }
}