import 'dart:io';

import 'package:flutter_media_metadata/flutter_media_metadata.dart';

class FileUtility {
  static Future<Metadata> getMetadataFromPath(String path) async {
    return await MetadataRetriever.fromFile(File(path));
  }
}
