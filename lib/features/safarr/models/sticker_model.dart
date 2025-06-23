import 'package:equatable/equatable.dart';

class StickerModel extends Equatable {
  const StickerModel({
    required this.name,
    required this.category,
    this.color,
    this.iconCode,
  });

  factory StickerModel.fromJson(Map<String, dynamic> json) {
    return StickerModel(
      name: json['name'] as String,
      category: json['category'] as String,
      color: json['color'] as String?,
      iconCode: json['iconCode'] as int?,
    );
  }

  final String name;
  final String category;
  final String? color;
  final int? iconCode;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'color': color,
      'iconCode': iconCode,
    };
  }

  StickerModel copyWith({
    String? name,
    String? category,
    String? color,
    int? iconCode,
  }) {
    return StickerModel(
      name: name ?? this.name,
      category: category ?? this.category,
      color: color ?? this.color,
      iconCode: iconCode ?? this.iconCode,
    );
  }

  @override
  List<Object?> get props => [name, category, color, iconCode];
}
