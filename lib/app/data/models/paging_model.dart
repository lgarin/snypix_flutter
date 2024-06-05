class PagingParameter {
  final int pageNumber;
  final int pageSize;
  final int? timestamp;

  PagingParameter({required this.pageSize, this.pageNumber = 0})
      : timestamp = null;

  PagingParameter.fromJson(Map<String, dynamic> json)
      : pageNumber = json['pageNumber'],
        pageSize = json['pageSize'],
        timestamp = json['timestamp'];
}

typedef PageContentBuilder<T> = List<T> Function(List<dynamic> json);

abstract class ResultPage<T> {
  final List<T> content;
  final PagingParameter? nextPage;
  final int pageCount;
  final int pageNumber;

  ResultPage.fromJson(
      Map<String, dynamic> json, PageContentBuilder<T> contentBuilder)
      : content = contentBuilder(json['content']),
        nextPage = json['nextPage'] != null
            ? PagingParameter.fromJson(json['nextPage'])
            : null,
        pageCount = json['pageCount'],
        pageNumber = json['pageNumber'];
}
