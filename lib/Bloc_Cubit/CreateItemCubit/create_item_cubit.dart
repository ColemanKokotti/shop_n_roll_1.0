import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'create_item_state.dart';
import '../../../Data/DataUi/ui_data.dart';

class CreateItemCubit extends Cubit<CreateItemState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UIControllerData _uiData;

  CreateItemCubit() : _uiData = UIControllerData(), super(CreateItemState()) {
    _uiData.nameController.addListener(_updateNameFromController);
    _uiData.descriptionController.addListener(_updateDescriptionFromController);
    _uiData.quantityController.addListener(_updateQuantityFromController);
    _uiData.priceController.addListener(_updatePriceFromController);
  }

  TextEditingController get nameController => _uiData.nameController;
  TextEditingController get descriptionController => _uiData.descriptionController;
  TextEditingController get quantityController => _uiData.quantityController;
  TextEditingController get priceController => _uiData.priceController;

  void _updateNameFromController() {
    emit(state.copyWith(nameItem: _uiData.nameController.text));
  }

  void _updateDescriptionFromController() {
    emit(state.copyWith(descriptionItem: _uiData.descriptionController.text));
  }

  void _updateQuantityFromController() {
    final quantityValue = int.tryParse(_uiData.quantityController.text) ?? 1;
    final unitPrice = state.unitPrice;
    final totalPrice = unitPrice * quantityValue;
    emit(state.copyWith(
      quantity: quantityValue,
      totalPrice: totalPrice
    ));
  }

  void _updatePriceFromController() {
    final priceValue = double.tryParse(_uiData.priceController.text) ?? 0.0;
    final quantity = state.quantity;
    final totalPrice = priceValue * quantity;
    emit(state.copyWith(
      unitPrice: priceValue,
      totalPrice: totalPrice
    ));
  }


  void setSelectedIcon(String icon) {
    emit(state.copyWith(selectedIcon: icon));
  }

  void increaseQuantity() {
    final newQuantity = state.quantity + 1;
    _uiData.quantityController.text = newQuantity.toString();
    emit(state.copyWith(quantity: newQuantity));
  }

  void decreaseQuantity() {
    final newQuantity = state.quantity > 0 ? state.quantity - 1 : 0;
    quantityController.text = newQuantity.toString();
    emit(state.copyWith(quantity: newQuantity));
  }


  Future<bool> addItem(BuildContext context) async {
    final theme = Theme.of(context);
    final isValid = await UIValidation.validateFields(
      context,
      name: state.nameItem,
      description: state.descriptionItem,
      icon: state.selectedIcon,
      theme: theme,
    );
    if (!isValid) return false;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final quantity = state.quantity;
      final unitPrice = state.unitPrice;
      final totalPrice = unitPrice * quantity;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('items')
          .add({
            'nameItem': state.nameItem,
            'iconItem': state.selectedIcon,
            'descriptionItem': state.descriptionItem,
            'quantity': quantity,
            'unitPrice': unitPrice,
            'totalPrice': totalPrice,
            'id': FieldValue.serverTimestamp(),
            'createdAt': FieldValue.serverTimestamp()
          });

      // Aggiorniamo lo stato con il prezzo totale
      emit(state.copyWith(
        quantity: quantity,
        unitPrice: unitPrice,
        totalPrice: totalPrice
      ));

      emit(state.reset());
      return true;
    } catch (e) {
      print("Errore nell'aggiungere l'elemento: $e");
      return false;
    }
  }

  void reset() {
    _uiData.nameController.clear();
    _uiData.descriptionController.clear();
    _uiData.quantityController.text = '1';
    _uiData.priceController.text = '0.0';
    emit(state.reset());
  }

  @override
  Future<void> close() {
    _uiData.dispose();
    return super.close();
  }
}
