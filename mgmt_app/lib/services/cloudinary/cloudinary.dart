import 'dart:io';

import 'package:cloudinary/cloudinary.dart';



class CloudinaryService {
  static final cloudinary = Cloudinary.signedConfig(
    apiKey: String.fromEnvironment('CLOUDINARY_API_KEY'),
    apiSecret: String.fromEnvironment('CLOUDINARY_API_SECRET'),
    cloudName: String.fromEnvironment('CLOUDINARY_CLOUD_NAME'),
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
}