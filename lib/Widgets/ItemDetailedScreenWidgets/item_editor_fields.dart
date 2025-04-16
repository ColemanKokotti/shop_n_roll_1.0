import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';
import '../../Bloc_Cubit/ModifyIconCubit/icon_selector_cubit.dart';
import '../../Bloc_Cubit/ModifyIconCubit/icon_selector_state.dart';
import '../../Data/data_icons.dart';

class NameField extends StatefulWidget {
  final String initialValue;

  const NameField({
    super.key,
    required this.initialValue,
  });

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(NameField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            hintText: 'Enter item name'.tr(),
          ),
          onChanged: (value) {
            context.read<ItemDetailCubit>().updateEditingField('nameItem', value);
          },
        ),
      ],
    );
  }
}

class PriceField extends StatefulWidget {
  final double initialValue;

  const PriceField({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<PriceField> createState() => _PriceFieldState();
}

class _PriceFieldState extends State<PriceField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(PriceField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            hintText: 'Enter price'.tr(),
            prefixText: '€ ',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: (value) {
            double? price = double.tryParse(value);
            if (price != null) {
              context.read<ItemDetailCubit>().updateEditingPrice(price);
            }
          },
        ),
      ],
    );
  }
}

class QuantityField extends StatefulWidget {
  final int initialValue;

  const QuantityField({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<QuantityField> createState() => _QuantityFieldState();
}

class _QuantityFieldState extends State<QuantityField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void didUpdateWidget(QuantityField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quantity'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            hintText: 'Enter quantity'.tr(),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            int? quantity = int.tryParse(value);
            if (quantity != null) {
              context.read<ItemDetailCubit>().updateEditingQuantity(quantity);
            }
          },
        ),
      ],
    );
  }
}

class IconField extends StatelessWidget {
  final String initialValue;
  final String documentId;

  const IconField({
    Key? key,
    required this.initialValue,
    required this.documentId,
  }) : super(key: key);

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
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: iconNames.length,
                    itemBuilder: (context, index) {
                      final String iconName = iconNames[index];
                      final Widget iconWidget = getWidgetFromString(iconName, size: 30, color: theme.iconTheme.color);
                      final bool isSelected = state.currentIconName == iconName;

                      return GestureDetector(
                        onTap: () {
                          cubit.updateIcon(iconName);
                          // Also update in the ItemDetailCubit
                          context.read<ItemDetailCubit>().updateEditingField('iconItem', iconName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? theme.secondaryHeaderColor : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: iconWidget,
                        ),
                      );
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
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            theme.primaryColor,
                          ),
                        ),
                        child: Text(
                          'Confirm'.tr(),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            theme.buttonTheme.colorScheme?.error,
                          ),
                        ),
                        child: Text(
                          'Cancel'.tr(),
                          style: theme.textTheme.bodyMedium,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Icon'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        BlocProvider(
          create: (context) => IconSelectorCubit(
            initialIconName: initialValue,
            documentId: documentId,
            currentUser: FirebaseAuth.instance.currentUser,
          ),
          child: BlocBuilder<IconSelectorCubit, IconSelectorState>(
            builder: (context, state) {
              final cubit = context.read<IconSelectorCubit>();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: getWidgetFromString(state.currentIconName, color: theme.iconTheme.color, size: 36),
                    tooltip: 'Select Icon'.tr(),
                    iconSize: 36,
                    onPressed: () => _showIconSelector(context, cubit),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class DescriptionField extends StatefulWidget {
  final String initialValue;

  const DescriptionField({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  @override
  State<DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<DescriptionField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(DescriptionField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            isDense: true,
            hintText: 'Enter item description'.tr(),
          ),
          maxLines: 4,
          onChanged: (value) {
            context.read<ItemDetailCubit>().updateEditingField('descriptionItem', value);
          },
        ),
      ],
    );
  }
}