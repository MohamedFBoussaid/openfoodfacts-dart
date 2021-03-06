// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult(
    page: JsonObject.parseInt(json['page']),
    pageSize: JsonObject.parseInt(json['page_size']),
    count: JsonObject.parseInt(json['count']),
    skip: JsonObject.parseInt(json['skip']),
    jsonProducts: json['products_json'] as List,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) {
  final val = <String, dynamic>{
    'page': instance.page,
    'page_size': instance.pageSize,
    'count': instance.count,
    'skip': instance.skip,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('products_json', instance.jsonProducts);
  writeNotNull('products', instance.products);
  return val;
}
