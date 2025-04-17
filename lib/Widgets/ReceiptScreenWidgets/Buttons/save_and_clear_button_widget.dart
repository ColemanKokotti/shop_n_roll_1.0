import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Bloc_Cubit/ReceiptCubit/receipt_cubit.dart';
import '../../../Bloc_Cubit/ReceiptCubit/receipt_state.dart';

class ReceiptSaveAndClearButton extends StatelessWidget {
  const ReceiptSaveAndClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptCubit, ReceiptState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return ElevatedButton(
          onPressed: () {
            context.read<ReceiptCubit>().saveReceiptAndClear();
            Navigator.pop(context);
          },
          style: theme.elevatedButtonTheme.style,
          child: Text('Save'.tr()),
        );
      },
    );
  }
}
