class PaginationModel {
  PaginationModel({this.page, this.size = 20, this.search});
  int? page;
  int? size;
  String? search;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (page != null) {
      data['page'] = page;
    }
    if (size != null) {
      data['size'] = size;
    }
    if (search != null) {
      data['search'] = search;
    }
    return data;
  }
}
