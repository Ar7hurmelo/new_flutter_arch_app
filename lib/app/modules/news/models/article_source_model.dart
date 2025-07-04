// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArticleSourceModel {
  String? id;
  String? name;

  ArticleSourceModel({this.id, this.name});

  ArticleSourceModel copyWith({String? id, String? name}) {
    return ArticleSourceModel(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory ArticleSourceModel.empty() {
    return ArticleSourceModel(id: '', name: '');
  }

  factory ArticleSourceModel.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      return ArticleSourceModel.empty();
    }

    return ArticleSourceModel(id: map['id'], name: map['name']);
  }

  String toJson() => json.encode(toMap());

  factory ArticleSourceModel.fromJson(String source) =>
      ArticleSourceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ArticleSourceModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant ArticleSourceModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
