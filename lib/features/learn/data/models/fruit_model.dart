class FruitModel {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? filename;
  final String? romanName;
  final String? technicalFile;

  FruitModel({
    this.id,
    this.name,
    this.description,
    this.type,
    this.filename,
    this.romanName,
    this.technicalFile,
  });

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      filename: json['filename'],
      romanName: json['roman_name'],
      technicalFile: json['technicalFile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'filename': filename,
      'roman_name': romanName,
      'technicalFile': technicalFile,
    };
  }
}