import 'dart:convert';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';



class CloudinaryService {
  static final cloudinary = Cloudinary.signedConfig(
    apiKey: const String.fromEnvironment('CLOUDINARY_API_KEY'),
    apiSecret: const String.fromEnvironment('CLOUDINARY_API_SECRET'),
    cloudName: const String.fromEnvironment('CLOUDINARY_CLOUD_NAME'),
  );

  static upload (File? file, String folder) async {
    final response = await cloudinary.upload
    (
      file: file?.path,
      fileBytes: file?.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: folder,
      fileName: file?.path.split('/').last,
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      }
    );    
    return response.secureUrl;
  }

    static uploadInvocie (dynamic? file, String folder, String orderNumber) async {
    var b = jsonEncode(file);
    print(CloudinaryResourceType.values);
    final response = await cloudinary.upload
    (
      fileBytes: utf8.encode(b),
      resourceType: CloudinaryResourceType.auto,
      folder: folder,
      fileName: 'INVOICE-${orderNumber}',
      file: 'pdf',
      progressCallback: (count, total) {
        print('Uploading image from file with progress: $count/$total');
      }
    );    
    return response.secureUrl;
  }
}