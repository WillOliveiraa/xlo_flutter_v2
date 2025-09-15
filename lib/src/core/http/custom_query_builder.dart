enum OrderByOptions { ascending, descending }

class OrderBy {
  final OrderByOptions? orderBy;
  final String? orderByColumn;

  OrderBy(this.orderBy, this.orderByColumn);
}

class CustomQueryBuilder {
  final String tableName;
  final List<String>? includes;
  final OrderBy? orderBy;
  final Map<String, dynamic>? whereEqualTo;

  CustomQueryBuilder({
    required this.tableName,
    this.includes,
    this.orderBy,
    this.whereEqualTo,
  });

  bool get hasIncludes => includes != null;
}
