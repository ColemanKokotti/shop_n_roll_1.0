class CreateItemState {
  final String nameItem;
  final String descriptionItem;
  final String selectedIcon;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  CreateItemState({
    this.nameItem = '',
    this.descriptionItem = '',
    this.selectedIcon = '',
    this.quantity = 1,
    this.unitPrice = 0.0,
    this.totalPrice = 0.0,
  });

  CreateItemState copyWith({
    String? nameItem,
    String? descriptionItem,
    String? selectedIcon,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? imageUrl,
  }) {
    return CreateItemState(
      nameItem: nameItem ?? this.nameItem,
      descriptionItem: descriptionItem ?? this.descriptionItem,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  CreateItemState reset() {
    return CreateItemState(
      nameItem: '',
      descriptionItem: '',
      selectedIcon: '',
      quantity: 1,
      unitPrice: 0.0,
      totalPrice: totalPrice,
    );
  }
}
