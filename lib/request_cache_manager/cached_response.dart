import 'package:hive_flutter/adapters.dart';

class CachedResponse {
  final Duration duration;
  final DateTime dateTime;
  final dynamic content;

  const CachedResponse({
    required this.dateTime,
    required this.duration,
    this.content,
  });

  bool isValid() {
    final difference = DateTime.now().difference(dateTime);
    final compared = duration.compareTo(difference);
    return compared == 1;
  }
}

class CachedResponseAdapter extends TypeAdapter<CachedResponse> {
  @override
  final typeId = 0;

  @override
  CachedResponse read(BinaryReader reader) {
    final read = reader.read();
    return CachedResponse(
      duration: Duration(milliseconds: read['duration']),
      dateTime: DateTime.parse(read['dateTime']),
      content: read['content'],
    );
  }

  @override
  void write(BinaryWriter writer, CachedResponse cachedResponse) {

    writer.write({
      "duration": cachedResponse.duration.inMilliseconds,
      "dateTime": cachedResponse.dateTime.toString(),
      "content": cachedResponse.content,
    });
  }
}