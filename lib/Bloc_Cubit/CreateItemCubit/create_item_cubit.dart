import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'create_item_state.dart';
import 'create_item_validation.dart';

class CreateItemCubit extends Cubit<CreateItemState> {
  final CollectionReference _itemsCollection = FirebaseFirestore.instance.collection('Items');
  final ImagePicker _picker = ImagePicker();
  
  CreateItemCubit() : super(CreateItemState());

  void updateName(String name) {
    emit(state.copyWith(nameItem: name));
  }

  void updateDescription(String description) {
    emit(state.copyWith(descriptionItem: description));
  }

  void updateQuantity(String quantity) {
    final quantityValue = int.tryParse(quantity) ?? 1;
    emit(state.copyWith(quantity: quantityValue));
  }

  void setSelectedIcon(String icon) {
    emit(state.copyWith(selectedIcon: icon));
  }

  void increaseQuantity() {
    final newQuantity = state.quantity + 1;
    emit(state.copyWith(quantity: newQuantity));
  }

  void decreaseQuantity() {
    final newQuantity = state.quantity > 0 ? state.quantity - 1 : 0;
    emit(state.copyWith(quantity: newQuantity));
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(state.copyWith(imageUrl: image.path));
      }
    } catch (e) {
      print("Errore durante la selezione dell'immagine: $e");
    }
  }

  bool validateFields() {
    return CreateItemValidation.validateFields(
      state.nameItem,
      state.descriptionItem,
      state.selectedIcon
    );
  }

  Future<bool> addItem() async {
    if (!validateFields()) {
      return false;
    }

    try {
      await _itemsCollection.add({
        'nameItem': state.nameItem,
        'iconItem': state.selectedIcon,
        'descriptionItem': state.descriptionItem,
        'quantity': state.quantity,
        'imageUrl': state.imageUrl,
      });

      reset();
      return true;
    } catch (e) {
      print("Errore nell'aggiungere l'elemento: $e");
      return false;
    }
  }

  void reset() {
    emit(CreateItemState());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
