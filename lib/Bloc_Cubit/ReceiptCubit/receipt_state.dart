import 'package:equatable/equatable.dart';

class ReceiptState extends Equatable {
  final bool isLoading;
  final List<Map<String, dynamic>> items;
  final double totalPrice;
  final String? error;

  const ReceiptState({
    this.isLoading = false,
    this.items = const [],
    this.totalPrice = 0.0,
    this.error,
  });

  ReceiptState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? items,
    double? totalPrice,
    String? error,
  }) {
    return ReceiptState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, totalPrice, error];
}
