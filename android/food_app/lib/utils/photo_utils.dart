import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

typedef PickSource = ImageSource;

/// ## Image picker
///
/// ### input:
///
///   **<span style="color: yellow">[imageSource]</span>** can be PickSource (recommended) or ImageSource
///
///   **<span style="color: yellow">[onError]</span>**(optional) callBack will be called when error happens.
///
/// ### return:
///
///   image binary list on success
///
///   null if failed
Future<Uint8List?> imagePicker(PickSource imageSource, {void Function(String message)? onError}) async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(source: imageSource);
  if (image == null) {
    if (onError != null) {
      onError("Failed to pick image!");
    }
    return null;
  }
  return await image.readAsBytes();
}
