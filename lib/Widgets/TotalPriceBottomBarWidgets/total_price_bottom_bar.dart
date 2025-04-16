import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/price_stream_builder_widget.dart';


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

    return PriceStreamBuilder(
      priceStream: _totalPriceStream(),
      theme: theme,
    );
  }
}