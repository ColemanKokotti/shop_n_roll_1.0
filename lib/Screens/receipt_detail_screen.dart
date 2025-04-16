import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Widgets/ReceiptScreenWidgets/receipt_content_widget.dart';


class ReceiptDetailScreen extends StatelessWidget {
  final String receiptId;

  const ReceiptDetailScreen({super.key, required this.receiptId});

  Future<Map<String, dynamic>> _fetchReceiptData(BuildContext context, String receiptId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Get the receipt
      final receiptDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('receipts')
          .doc(receiptId)
          .get();

      if (!receiptDoc.exists) {
        throw Exception('Receipt not found');
      }

      final receiptData = receiptDoc.data() as Map<String, dynamic>;
      
      // Get the saved items
      final savedItems = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('savedItems')
          .where('id', whereIn: (receiptData['items'] as List<dynamic>).map((item) => item['id']).toList())
          .get();

      if (savedItems.docs.isEmpty) {
        throw Exception('Items not found');
      }

      // Convert saved items to the expected format
      final items = savedItems.docs.map((doc) => {
        ...doc.data(),
        'id': doc.id,
      }).toList();

      return {
        'items': items,
        'totalPrice': receiptData['totalPrice'] as double,
      };
    } catch (e) {
      rethrow;
    }
  }

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
          'Receipt Detail'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('receipts')
                  .doc(receiptId)
                  .delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _fetchReceiptData(context, receiptId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'.tr()));
              }

              if (!snapshot.hasData) {
                return Center(child: Text('Receipt not found'.tr()));
              }

              final receiptData = snapshot.data!;
              return ReceiptContent(
                items: receiptData['items'] as List<Map<String, dynamic>>,
                totalPrice: receiptData['totalPrice'] as double,
              );
            },
          ),
        ),
      ),
    );
  }
}
