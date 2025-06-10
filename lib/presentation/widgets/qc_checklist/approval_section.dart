import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/attachment.dart';

class FileAttachmentPicker extends StatefulWidget {
  final void Function(List<Attachment> attachments) onAttachmentsChanged;

  const FileAttachmentPicker({Key? key, required this.onAttachmentsChanged})
    : super(key: key);

  @override
  _FileAttachmentPickerState createState() => _FileAttachmentPickerState();
}

class _FileAttachmentPickerState extends State<FileAttachmentPicker> {
  final List<Attachment> _attachments = [];
  final ImagePicker _imagePicker = ImagePicker();
  final double _buttonHeight = 120;
  final double _thumbnailSize = 64;

  Future<void> _addAttachment(Attachment attachment) async {
    setState(() => _attachments.add(attachment));
    widget.onAttachmentsChanged(_attachments);
  }

  void _removeAttachment(int index) {
    setState(() => _attachments.removeAt(index));
    widget.onAttachmentsChanged(_attachments);
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        await _processFile(File(pickedFile.path), pickedFile.name);
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _pickFromStorage() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final PlatformFile file = result.files.single;
        await _processFile(File(file.path!), file.name);
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _processFile(File file, String fileName) async {
    final bytes = await file.readAsBytes();
    if (bytes.length > 5 * 1024 * 1024) {
      throw Exception('File too large (max 5MB)');
    }

    _addAttachment(
      Attachment(file: file, base64: base64Encode(bytes), name: fileName),
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error), duration: const Duration(seconds: 2)),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionButton(
                    icon: Icons.camera_alt,
                    text: 'Take Photo',
                    onTap: _takePhoto,
                  ),
                  const SizedBox(width: 16),
                  _buildOptionButton(
                    icon: Icons.folder_open,
                    text: 'Upload File',
                    onTap: _pickFromStorage,
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: _buttonHeight,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(text, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentItem(Attachment attachment, int index) {
    final isImage =
        attachment.name.toLowerCase().endsWith('.jpg') ||
        attachment.name.toLowerCase().endsWith('.jpeg') ||
        attachment.name.toLowerCase().endsWith('.png');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: _thumbnailSize,
            height: _thumbnailSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child:
                isImage
                    ? Image.file(attachment.file, fit: BoxFit.cover)
                    : const Icon(Icons.insert_drive_file, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${(attachment.file.lengthSync() / 1024).toStringAsFixed(1)} KB',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => _removeAttachment(index),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _showAttachmentOptions,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add),
              const SizedBox(width: 8),
              const Text('Add Attachment'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_attachments.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uploaded Files',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ..._attachments.asMap().entries.map(
                (entry) => _buildAttachmentItem(entry.value, entry.key),
              ),
            ],
          ),
      ],
    );
  }
}
