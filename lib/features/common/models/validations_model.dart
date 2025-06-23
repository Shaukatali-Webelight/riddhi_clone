class ValidationsModel {
  ValidationsModel({
    required this.required,
    this.regex,
    this.min,
    this.max,
    this.same,
    this.gt,
  });
  String required;
  String? regex;
  String? min;
  String? max;
  String? same;
  String? gt;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['required'] = required;
    if (regex != null) {
      data['regex'] = regex ?? '';
    }
    if (min != null) {
      data['min'] = min ?? '';
    }
    if (max != null) {
      data['max'] = max ?? '';
    }
    if (same != null) {
      data['same'] = same ?? '';
    }
    if (gt != null) {
      data['gt'] = gt ?? '';
    }

    return data;
  }
}
