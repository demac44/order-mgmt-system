


class MenuItem {
  final int id;
  final String title;

  const MenuItem({
    required this.id,
    required this.title,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
      } =>
        MenuItem(
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class MenuFilters {
  final int? category;
  final String? search;

  const MenuFilters({
    this.category,
    this.search,
  });
}