class BoughtItemState {
  final bool isBought;

  BoughtItemState({this.isBought = false});

  BoughtItemState copyWith({bool? isBought}) {
    return BoughtItemState(
      isBought: isBought ?? this.isBought,
    );
  }
}
