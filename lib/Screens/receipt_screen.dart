import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Bloc_Cubit/ReceiptCubit/receipt_cubit.dart';
import '../Bloc_Cubit/ReceiptCubit/receipt_state.dart';
import '../Widgets/ReceiptScreenWidgets/receipt_content_widget.dart';


class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
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