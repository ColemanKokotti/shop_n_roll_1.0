import 'package:equatable/equatable.dart';
import '../../Data/data_items.dart';

class ItemDetailState extends Equatable {
  final bool isLoading;
  final Map<String, dynamic>? itemData;
  final String? error;
  final bool isEditing;
  final Item? editingItem;

  const ItemDetailState({
    this.isLoading = false,
    this.itemData,
    this.error,
    this.isEditing = false,
    this.editingItem,
  });

  ItemDetailState copyWith({
    bool? isLoading,
    Map<String, dynamic>? itemData,
    String? error,
    bool? isEditing,
    Item? editingItem,
  }) {
    return ItemDetailState(
      isLoading: isLoading ?? this.isLoading,
      itemData: itemData ?? this.itemData,
      error: error ?? this.error,
      isEditing: isEditing ?? this.isEditing,
      editingItem: editingItem ?? this.editingItem,
    );
  }

  @override
  List<Object?> get props => [isLoading, itemData, error, isEditing, editingItem];
}