class MediaUploadInputModel {
  MediaUploadInputModel({this.filename, this.fileType, this.token, this.id, this.accessControl});

  MediaUploadInputModel.fromJson(Map<String, dynamic> json) {
    filename = json['fileName'] as String?;
    fileType = json['fileType'] as String?;
    token = json['token'] as String?;
    id = json['id'] as String?;
    accessControl = json['accessControl'] as String?;
  }
  String? filename;
  String? fileType;
  String? accessControl;
  String? token;
  String? id;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if ((filename ?? '').isNotEmpty) {
      data['fileName'] = filename;
    }
    if ((fileType ?? '').isNotEmpty) {
      data['fileType'] = fileType;
    }
    if ((accessControl ?? '').isNotEmpty) {
      data['accessControl'] = accessControl;
    }
    if ((token ?? '').isNotEmpty) {
      data['token'] = token;
    }
    if ((id ?? '').isNotEmpty) {
      data['id'] = id;
    }
    return data;
  }
}
