class Toggleable {
  /// Unique identifier for switches
  final String alias;
  final String title;
  final String? description;

  Toggleable({
    required this.alias,
    required this.title,
    this.description,
  });

  Toggleable copyWith({
    String? title,
    String? description,
    String? alias,
  }) =>
      Toggleable(
        title: title ?? this.title,
        description: description ?? this.description,
        alias: alias ?? this.alias,
      );

  @override
  bool operator ==(Object other) =>
      other is Toggleable &&
      alias == other.alias &&
      title == other.title &&
      description == other.description;

  @override
  int get hashCode => Object.hash(
        alias,
        title,
        description,
      );
}
