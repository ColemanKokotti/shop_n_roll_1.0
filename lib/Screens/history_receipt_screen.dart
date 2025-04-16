import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Bloc_Cubit/ReceiptHistoryCubit/receipt_history_cubit.dart';
import '../../Bloc_Cubit/ReceiptHistoryCubit/receipt_history_state.dart';
import './receipt_detail_screen.dart';

class HistoryReceiptScreen extends StatelessWidget {
  const HistoryReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        title: Text(
          'Receipt History'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ReceiptHistoryCubit(
            FirebaseFirestore.instance,
            FirebaseAuth.instance,
          )..loadReceiptHistory(),
          child: BlocBuilder<ReceiptHistoryCubit, ReceiptHistoryState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.error != null) {
                return Center(child: Text(state.error!));
              }

              if (state.receipts.isEmpty) {
                return Center(
                  child: Text(
                    'No receipts yet'.tr(),
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.receipts.length,
                itemBuilder: (context, index) {
                  final receipt = state.receipts[index];
                  final createdAt = (receipt['createdAt'] as Timestamp).toDate();

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        '${'Receipt'.tr()} ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${createdAt.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                          Text(
                            'Total: ${receipt['totalPrice'].toStringAsFixed(2)}',
                            style: TextStyle(color: theme.primaryColor),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiptDetailScreen(
                              receiptId: receipt['id'],
                            ),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<ReceiptHistoryCubit>().deleteReceipt(receipt['id']);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}