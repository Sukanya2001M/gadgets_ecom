class Entity {
  final String id;
  final String name;
  final Map<String, dynamic>? data;

  Entity({
    required this.id,
    required this.name,
    this.data,
  });
}
