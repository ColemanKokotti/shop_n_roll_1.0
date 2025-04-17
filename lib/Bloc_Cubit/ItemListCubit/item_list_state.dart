import 'package:equatable/equatable.dart';

class ItemListState extends Equatable {
  final Map<String, dynamic>? deletedItem;
  final bool isItemRestored;

  const ItemListState({
    this.deletedItem,
    this.isItemRestored = false,
  });

  ItemListState copyWith({
    Map<String, dynamic>? deletedItem,
    bool? isItemRestored,
  }) {
    return ItemListState(
      deletedItem: deletedItem ?? this.deletedItem,
      isItemRestored: isItemRestored ?? this.isItemRestored,
    );
  }

  @override
  List<Object?> get props => [deletedItem, isItemRestored];
}