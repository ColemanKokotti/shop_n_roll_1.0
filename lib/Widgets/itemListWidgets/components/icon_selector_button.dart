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
    final borderRadius = BorderRadius.circular(30);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<IconSelectorCubit, IconSelectorState>(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: theme.cardTheme.color,
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                title: Text(
                  'Select an icon for editing:'.tr(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: borderRadius),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel'.tr(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: borderRadius),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Confirm'.tr(),
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
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
    final borderRadius = BorderRadius.circular(30);

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
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2.0,
                ),
              ),
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.all(8),
            ),
            icon: getWidgetFromString(state.currentIconName, color: theme.colorScheme.primary),
            onPressed: () => _showIconSelector(context, cubit),
          );
        },
      ),
    );
  }
}