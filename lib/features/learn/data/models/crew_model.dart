class CrewModel {
  final int? id;
  final String? name;
  final String? description;
  final String? status;
  final String? number;
  final String? romanName;
  final String? totalPrime;
  final bool? isYonko;

  CrewModel({
    this.id,
    this.name,
    this.description,
    this.status,
    this.number,
    this.romanName,
    this.totalPrime,
    this.isYonko,
  });

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      number: json['number'],
      romanName: json['roman_name'],
      totalPrime: json['total_prime'],
      isYonko: json['is_yonko'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'number': number,
      'roman_name': romanName,
      'total_prime': totalPrime,
      'is_yonko': isYonko,
    };
  }
}