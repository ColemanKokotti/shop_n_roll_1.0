import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_n_roll/Widgets/CreateItemWidgets/quantity_selector_widget.dart';
import 'package:shop_n_roll/Widgets/CreateItemWidgets/text_field_widget.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import 'action_buttons_widget.dart';
import 'icon_selectorwidget.dart';

class CreateItemDialog extends StatelessWidget {
  const CreateItemDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CreateItemCubit>();
    final state = context.watch<CreateItemCubit>().state;

    return SafeArea(
      child: AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Add item'.tr(),
          textAlign: TextAlign.center,
        ),
        titleTextStyle: TextStyle(
          color: theme.textTheme.labelLarge?.color,
          fontSize: 30,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                controller: cubit.nameController,
                labelText: 'Item name'.tr(),
                theme: theme,
              ),
              SizedBox(height: 8),
              TextFieldWidget(
                controller: cubit.descriptionController,
                labelText: 'Item description'.tr(),
                theme: theme,
                maxLines: 9,
                minLines: 4,
              ),
              SizedBox(height: 8),
              QuantitySelectorWidget(cubit: cubit, theme: theme),
              SizedBox(height: 8),
              IconSelectorWidget(
                selectedIcon: state.selectedIcon,
                onIconSelect: (newIcon) => cubit.setSelectedIcon(newIcon),
              ),
              SizedBox(height: 8),
              ActionButtonsWidget(cubit: cubit, state: state),
            ],
          ),
        ),
      ),
    );
  }
}