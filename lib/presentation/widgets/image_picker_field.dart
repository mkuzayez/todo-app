import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/presentation/custom_widgets/custom_text.dart';
import 'package:todo_app/theme/text.dart';

class ImagePickerField extends StatefulWidget {
  final ValueChanged<String?> onImagePicked;
  final String? existingImagePath;

  const ImagePickerField({
    super.key,
    required this.onImagePicked,
    this.existingImagePath,
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  String? selectedImagePath;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    selectedImagePath = widget.existingImagePath;
  }

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImagePath = pickedImage.path;
      });
      widget.onImagePicked(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor = selectedImagePath != null
        ? Colors.white
        : Theme.of(context).colorScheme.onPrimary;

    return GestureDetector(
      onTap: pickImage,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 52,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: boxColor,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: selectedImagePath == null
                    ? "Add Image (Optional)"
                    : "Image Added",
                style: customTextTheme.bodyLarge!,
                color: boxColor,
              ),
              Image.asset(
                'assets/icons/image.png',
                color: boxColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
