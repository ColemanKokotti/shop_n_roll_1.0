class ItemListState {
  final Map<String, dynamic>? deletedItem;
  final String? deletedItemId;
  final Map<String, int> itemQuantities;
  final String? errorMessage;
  final bool isItemRestored;

  ItemListState({
    this.deletedItem,
    this.deletedItemId,
    this.itemQuantities = const {},
    this.errorMessage,
    this.isItemRestored = false,
  });

  ItemListState copyWith({
    Map<String, dynamic>? deletedItem,
    String? deletedItemId,
    Map<String, int>? itemQuantities,
    String? errorMessage,
    bool? isItemRestored,
  }) {
    return ItemListState(
      deletedItem: deletedItem,
      deletedItemId: deletedItemId,
      itemQuantities: itemQuantities ?? this.itemQuantities,
      errorMessage: errorMessage,
      isItemRestored: isItemRestored ?? this.isItemRestored,
    );
  }

  ItemListState clearDeletedItem() {
    return copyWith(
      deletedItem: null,
      deletedItemId: null,
      errorMessage: null,
      isItemRestored: true,
    );
  }

  ItemListState updateQuantity(String itemId, int quantity) {
    return copyWith(
      itemQuantities: Map.from(itemQuantities)..[itemId] = quantity,
      errorMessage: null,
    );
  }

  ItemListState setError(String message) {
    return copyWith(errorMessage: message);
  }
<<<<<<< Updated upstream
}
=======
}
>>>>>>> Stashed changes
