import 'package:flutter/material.dart';
import '../../Bloc_Cubit/CreateItemCubit/create_item_cubit.dart';

class CreateItemControllerAdapter {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController(text: '1');
  final CreateItemCubit cubit;

  CreateItemControllerAdapter(this.cubit) {
    nameController.addListener(() => cubit.updateName(nameController.text));
    descriptionController.addListener(() => cubit.updateDescription(descriptionController.text));
    quantityController.addListener(() => cubit.updateQuantity(quantityController.text));
  }

  void reset() {
    nameController.clear();
    descriptionController.clear();
    quantityController.text = '1';
  }

  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
  }
}
