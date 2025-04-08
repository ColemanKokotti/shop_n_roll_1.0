import 'package:flutter_bloc/flutter_bloc.dart';
import 'bought_item_state.dart';

class BoughtItemCubit extends Cubit<BoughtItemState> {
  BoughtItemCubit() : super(BoughtItemState());

  void toggleBoughtStatus() {
    emit(state.copyWith(isBought: !state.isBought));
  }
}