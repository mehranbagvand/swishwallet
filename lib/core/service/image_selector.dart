import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageSelector{
  ImagePicker picker = ImagePicker();

  Future<Uint8List?> selectPicture(ImageSource type)async{
    var file = await picker.pickImage(source: type);
    if(file==null) return null;
    return await file.readAsBytes();
  }

  start(ImageSource type)async=> await selectPicture(type);
}