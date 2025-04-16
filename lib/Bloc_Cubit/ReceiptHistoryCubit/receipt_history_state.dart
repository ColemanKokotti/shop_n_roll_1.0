class ReceiptHistoryState {
  final bool isLoading;
  final List<Map<String, dynamic>> receipts;
  final String? error;

  const ReceiptHistoryState({
    this.isLoading = false,
    this.receipts = const [],
    this.error,
  });

  ReceiptHistoryState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? receipts,
    String? error,
  }) {
    return ReceiptHistoryState(
      isLoading: isLoading ?? this.isLoading,
      receipts: receipts ?? this.receipts,
      error: error ?? this.error,
    );
  }
}
