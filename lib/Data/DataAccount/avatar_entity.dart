class AvatarEntity {
  final String path;
  final bool isSelected;

  AvatarEntity({
    required this.path,
    required this.isSelected,
  });

  AvatarEntity copyWith({
    String? path,
    bool? isSelected,
  }) {
    return AvatarEntity(
      path: path ?? this.path,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}