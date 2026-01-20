import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/widgets/error_snackbar.dart';

/// Profile Picture Picker Widget
/// Allows users to select a profile picture with a circular preview
/// Matches the design from code.html with camera icon button overlay
class ProfilePicturePicker extends StatefulWidget {
  final String name;
  final Function(XFile?)? onChanged;
  final Function(XFile?)? onSaved;
  final XFile? initialValue;
  final double size;

  const ProfilePicturePicker({
    super.key,
    required this.name,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.size = 112,
  });

  @override
  State<ProfilePicturePicker> createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialValue;
  }

  Future<void> _pickImage() async {
    try {
      // Show bottom sheet to choose between camera and gallery
      final XFile? image = await showModalBottomSheet<XFile?>(
        context: context,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: AppColors.primaryColor),
                  title: const Text('Take Photo'),
                  onTap: () async {
                    final image = await _picker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (context.mounted) {
                      Navigator.pop(context, image);
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: AppColors.primaryColor),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    final image = await _picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1024,
                      maxHeight: 1024,
                      imageQuality: 85,
                    );
                    if (context.mounted) {
                      Navigator.pop(context, image);
                    }
                  },
                ),
                if (_selectedImage != null)
                  ListTile(
                    leading: const Icon(Icons.delete, color: AppColors.error),
                    title: const Text('Remove Photo'),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                  ),
              ],
            ),
          ),
        ),
      );

      if (image != _selectedImage) {
        setState(() {
          _selectedImage = image;
        });
        widget.onChanged?.call(image);
      }
    } catch (e) {
      ErrorSnackbar.show(
        message: 'Failed to pick image. Please try again.',
        icon: Icons.error_outline,
      );
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormBuilderField<XFile?>(
      name: widget.name,
      initialValue: widget.initialValue,
      onSaved: (value) => widget.onSaved?.call(_selectedImage),
      builder: (FormFieldState<XFile?> field) {
        return Center(
          child: GestureDetector(
            onTap: _pickImage,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: Stack(
                children: [
                  // Main circular container
                  Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                      color: isDark
                          ? AppColors.surfaceDark
                          : const Color(0xFFF9FAFB),
                    ),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              File(_selectedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person,
                              size: widget.size * 0.5,
                              color: const Color(0xFFD1D5DB),
                            ),
                    ),
                  ),
                  // Camera button overlay
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.backgroundDark
                              : AppColors.backgroundLight,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
