// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'dateTime': instance.dateTime.toIso8601String(),
    };

const _$TaskStatusEnumMap = {
  TaskStatus.todo: 'todo',
  TaskStatus.doing: 'doing',
  TaskStatus.done: 'done',
};
