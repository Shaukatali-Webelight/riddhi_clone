class Media {
  Media({
    this.id,
    this.key,
    this.type,
    this.localUrl,
    this.networkUrl,
  });

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    key = json['key'] as String?;
    type = json['type'] as String?;
    localUrl = json['localUrl'] as String?;
    networkUrl = json['networkUrl'] as String?;
  }

  Media copyWith({
    String? id,
    String? key,
    String? type,
    String? localUrl,
    String? networkUrl,
  }) {
    return Media(
      id: id ?? this.id,
      key: key ?? this.key,
      type: type ?? this.type,
      localUrl: localUrl ?? this.localUrl,
      networkUrl: networkUrl ?? this.networkUrl,
    );
  }

  String? id;
  String? key;
  String? type;
  String? localUrl;
  String? networkUrl;
  String? get fileName {
    if ((key ?? '').isNotEmpty) {
      return (key ?? '').split('/').last;
    } else if ((networkUrl ?? '').isNotEmpty) {
      return (networkUrl ?? '').split('/').last;
    } else if ((localUrl ?? '').isNotEmpty) {
      return (localUrl ?? '').split('/').last;
    }
    return null;
  }

  String? get getKey {
    if ((key ?? '').isNotEmpty) {
      return key;
    } else if ((networkUrl ?? '').isNotEmpty) {
      return networkUrl?.split('.in/').last;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (key != null) {
      data['key'] = key;
    }
    if (type != null) {
      data['type'] = type;
    }
    if (localUrl != null) {
      data['localUrl'] = localUrl;
    }
    if (networkUrl != null) {
      data['networkUrl'] = localUrl;
    }
    return data;
  }
}
