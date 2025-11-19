import 'crew_model.dart';
import 'fruit_model.dart';

class CharacterModel {
  final int? id;
  final String? name;
  final String? size;
  final String? age;
  final String? bounty;
  final CrewModel? crew;
  final FruitModel? fruit;
  final String? job;
  final String? status;

  CharacterModel({
    this.id,
    this.name,
    this.size,
    this.age,
    this.bounty,
    this.crew,
    this.fruit,
    this.job,
    this.status,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      size: json['size'],
      age: json['age'],
      bounty: json['bounty'],
      crew: json['crew'] != null ? CrewModel.fromJson(json['crew']) : null,
      fruit: json['fruit'] != null ? FruitModel.fromJson(json['fruit']) : null,
      job: json['job'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'age': age,
      'bounty': bounty,
      'crew': crew?.toJson(),
      'fruit': fruit?.toJson(),
      'job': job,
      'status': status,
    };
  }

  // Helper pour affichage
  @override
  String toString() {
    return 'CharacterModel(id: $id, name: $name, crew: ${crew?.name}, fruit: ${fruit?.name})';
  }
}