import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Bloc_Cubit/ModifyIconCubit/icon_selector_cubit.dart';
import '../../../Bloc_Cubit/ModifyIconCubit/icon_selector_state.dart';
import '../../../Data/data_items.dart';
import 'modify_icon_widget.dart';

class IconSelectorButton extends StatelessWidget {
  final String currentIconName;
  final String documentId;

  const IconSelectorButton({
    super.key,
    required this.currentIconName,
    required this.documentId,
  });

  void _showIconSelector(BuildContext context, IconSelectorCubit cubit) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<IconSelectorCubit, IconSelectorState>(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: theme.cardColor,
                title: Text(
                  'Select an icon for editing:'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.labelLarge?.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  width: 300,
                  height: 150,
                  child: ModifyIconWidget(
                    selectedIcon: state.currentIconName,
                    documentId: documentId,
                    onIconSelect: (newIcon) {
                      cubit.updateIcon(newIcon);
                    },
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'.tr(), style: TextStyle(fontSize: 15)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Confirm'.tr(), style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => IconSelectorCubit(
        initialIconName: currentIconName,
        documentId: documentId,
        currentUser: FirebaseAuth.instance.currentUser,
      ),
      child: BlocBuilder<IconSelectorCubit, IconSelectorState>(
        builder: (context, state) {
          final cubit = context.read<IconSelectorCubit>();
          return IconButton(
            icon: getWidgetFromString(state.currentIconName, color: theme.iconTheme.color),
            onPressed: () => _showIconSelector(context, cubit),
          );
        },
      ),
    );
  }
}