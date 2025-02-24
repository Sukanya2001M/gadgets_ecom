import 'package:gadgets_ecom/Domain/Entity/Entity.dart';

class Model extends Entity {
  final Map<String, dynamic>? data;

  Model({
    required super.id,
    required super.name,
    this.data,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      name: json['name'],
      data: json['data'] is Map<String, dynamic> ? json['data'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data ?? {}, // Ensure it is always a Map
    };
  }

  static Model nullData = Model(id: "", name: "", data: null);
}
