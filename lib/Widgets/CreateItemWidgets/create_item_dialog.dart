import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';
import '../../UI/CreateItem/create_item_controller_adapter.dart';
import '../../UI/CreateItem/create_item_ui_helper.dart';
import 'action_buttons_widget.dart';
import 'icon_selectorwidget.dart';
import 'package:shop_n_roll/Widgets/CreateItemWidgets/quantity_selector_widget.dart';
import 'package:shop_n_roll/Widgets/CreateItemWidgets/text_field_widget.dart';

class CreateItemDialog extends StatefulWidget {
  const CreateItemDialog({super.key});

  @override
  State<CreateItemDialog> createState() => _CreateItemDialogState();
}

class _CreateItemDialogState extends State<CreateItemDialog> {
  late CreateItemControllerAdapter _controllerAdapter;

  @override
  void initState() {
    super.initState();
    _controllerAdapter = CreateItemControllerAdapter(context.read<CreateItemCubit>());
  }

  @override
  void dispose() {
    _controllerAdapter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<CreateItemCubit>();
    final state = context.watch<CreateItemCubit>().state;

    return SafeArea(
      child: AlertDialog(
        backgroundColor: theme.dialogTheme.backgroundColor,
        title: Text(
          'Add item'.tr(),
          textAlign: TextAlign.center,
          style: theme.dialogTheme.titleTextStyle,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldWidget(
                controller: _controllerAdapter.nameController,
                labelText: 'Item name'.tr(),
                theme: theme,
              ),
              SizedBox(height: 8),
              TextFieldWidget(
                controller: _controllerAdapter.descriptionController,
                labelText: 'Item description'.tr(),
                theme: theme,
                maxLines: 9,
                minLines: 4,
              ),
              SizedBox(height: 8),
              QuantitySelectorWidget(
                cubit: cubit,
                theme: theme,
                controllerAdapter: _controllerAdapter,
              ),
              SizedBox(height: 8),
              IconSelectorWidget(
                selectedIcon: state.selectedIcon,
                onIconSelect: (newIcon) => cubit.setSelectedIcon(newIcon),
              ),
              SizedBox(height: 8),
              ActionButtonsWidget(
                cubit: cubit,
                state: state,
                controllerAdapter: _controllerAdapter,
                onPressed: () async {
                  if (!cubit.validateFields()) {
                    CreateItemUIHelper.showValidationError(context, theme);
                    return;
                  }
                  
                  final success = await cubit.addItem();
                  if (success) {
                    _controllerAdapter.reset();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}