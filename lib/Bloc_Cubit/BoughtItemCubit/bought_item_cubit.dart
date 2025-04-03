import 'package:flutter_bloc/flutter_bloc.dart';

class BoughtItemCubit extends Cubit<bool> {
  BoughtItemCubit() : super(false);

  void toggleItemStatus() {
    emit(!state);
  }
}