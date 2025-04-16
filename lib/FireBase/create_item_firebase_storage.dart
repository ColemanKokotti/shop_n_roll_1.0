import 'package:cloud_firestore/cloud_firestore.dart';
import '../Bloc_Cubit/CreateItemCubit/create_item_state.dart';
import 'auth_service.dart';

class CreateItemFirebase {
  final AuthService _authService;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CreateItemFirebase(this._authService);

  Future<bool> addItemToUser(CreateItemState state) async {
    try {
      final currentUser = _authService.getCurrentUser();
      if (currentUser != null) {
        final userDoc = _firestore.collection('users').doc(currentUser.uid);
        await userDoc.collection('items').add({
          'nameItem': state.nameItem,
          'iconItem': state.selectedIcon,
          'descriptionItem': state.descriptionItem,
          'quantity': state.quantity,
          'unitPrice': state.unitPrice,
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Errore nell\'aggiungere l\'oggetto all\'utente: $e');
      return false;
    }
  }
}
