import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Bloc_Cubit/ReceiptCubit/receipt_cubit.dart';
import '../Bloc_Cubit/ReceiptCubit/receipt_state.dart';
import '../Data/data_items.dart';


class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ReceiptCubit(
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
      )..loadBoughtItems(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Receipt'.tr()),
          centerTitle: true,
        ),
        body: BlocBuilder<ReceiptCubit, ReceiptState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            if (state.items.isEmpty) {
              return Center(child: Text('No bought items'.tr()));
            }

            return ReceiptContent(items: state.items, totalPrice: state.totalPrice);
          },
        ),
      ),
    );
  }
}

class ReceiptContent extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalPrice;

  const ReceiptContent({
    super.key,
    required this.items,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final timeFormatter = DateFormat('HH:mm');

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Receipt Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Shopping Receipt'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateFormatter.format(now),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        timeFormatter.format(now),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Receipt Body
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Table Header
                  Row(
                    children: [
                      const SizedBox(width: 40), // For icon
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Item'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Qty'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Unit'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Total'.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  
                  const Divider(thickness: 1),
                  
                  // Items List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final String iconName = item['iconItem'] ?? 'error';
                      final String name = item['nameItem'] ?? 'Unknown';
                      final int quantity = item['quantity'] is int
                        ? item['quantity']
                        : int.tryParse(item['quantity'].toString()) ?? 0;
                      final double unitPrice = item['unitPrice'] is double
                        ? item['unitPrice']
                        : double.tryParse(item['unitPrice'].toString()) ?? 0.0;
                      final double itemTotalPrice = unitPrice * quantity;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: getWidgetFromString(iconName, color: Colors.black87, size: 24),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                name,
                                style: const TextStyle(color: Colors.black87),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(color: Colors.black87),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                unitPrice.toStringAsFixed(2),
                                style: const TextStyle(color: Colors.black87),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                itemTotalPrice.toStringAsFixed(2),
                                style: const TextStyle(color: Colors.black87),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  
                  const Divider(thickness: 1),
                  
                  // Total
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Spacer(flex: 6),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Total'.tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            totalPrice.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Thank you message
                  Text(
                    'Thank you for shopping!'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
