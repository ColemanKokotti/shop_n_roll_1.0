import 'package:equatable/equatable.dart';

class ItemDetailState extends Equatable {
  final bool isLoading;
  final Map<String, dynamic>? itemData;
  final String? error;

  const ItemDetailState({
    this.isLoading = false,
    this.itemData,
    this.error,
  });

  ItemDetailState copyWith({
    bool? isLoading,
    Map<String, dynamic>? itemData,
    String? error,
  }) {
    return ItemDetailState(
      isLoading: isLoading ?? this.isLoading,
      itemData: itemData ?? this.itemData,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, itemData, error];
}