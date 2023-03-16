import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if(imageFile == null){
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await File(imageFile!.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  File(_storedImage!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No image taken', textAlign: TextAlign.center),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take picture'),
            style: TextButton.styleFrom(
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
