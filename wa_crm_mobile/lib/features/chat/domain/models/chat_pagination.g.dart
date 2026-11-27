// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatPagination _$ChatPaginationFromJson(Map<String, dynamic> json) =>
    _ChatPagination(
      page: json['page'] == null ? 1 : asInt(json['page']),
      totalPages: json['totalPages'] == null ? 1 : asInt(json['totalPages']),
      total: json['total'] == null ? 0 : asInt(json['total']),
      limit: json['limit'] == null ? 30 : asInt(json['limit']),
    );

Map<String, dynamic> _$ChatPaginationToJson(_ChatPagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'totalPages': instance.totalPages,
      'total': instance.total,
      'limit': instance.limit,
    };
