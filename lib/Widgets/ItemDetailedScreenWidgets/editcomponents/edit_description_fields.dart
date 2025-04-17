import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../Bloc_Cubit/ItemDetailedCubit/item_detailed_cubit.dart';


class DescriptionField extends StatefulWidget {
  final String initialValue;

  const DescriptionField({
    super.key,
    required this.initialValue,
  });

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