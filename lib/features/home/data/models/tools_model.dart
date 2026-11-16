import '../../domain/entities/tools_item.dart';

class ToolsModel extends ToolsItem {
  const ToolsModel({
    required super.id,
    required super.image,
    required super.title,
    required super.subtitle,
    super.isNew = false,
    required super.actionType,
  });

  factory ToolsModel.fromJson(Map<String, dynamic> json) {
    return ToolsModel(
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      isNew: json['isNew'] as bool? ?? false,
      actionType: json['actionType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'isNew': isNew,
      'actionType': actionType,
    };
  }
}
