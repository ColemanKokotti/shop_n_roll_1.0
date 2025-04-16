class Item {
  final String id;
  final String nameItem;
  final String iconItem;
  final String descriptionItem;
  final double price;
  final int quantity;

  Item({
    required this.id,
    required this.nameItem,
    required this.iconItem,
    this.descriptionItem = '',
    this.price = 0.0,
    this.quantity = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Item &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              nameItem == other.nameItem &&
              iconItem == other.iconItem &&
              descriptionItem == other.descriptionItem &&
              price == other.price &&
              quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      nameItem.hashCode ^
      iconItem.hashCode ^
      descriptionItem.hashCode ^
      price.hashCode ^
      quantity.hashCode;
}