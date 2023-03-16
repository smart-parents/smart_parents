// ignore_for_file: non_constant_identifier_names


class DataModel {
  final String name;
  final String mime;
  final int bytes;
  final String Url;

  DataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.Url,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)}MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}
