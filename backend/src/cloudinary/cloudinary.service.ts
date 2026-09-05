import { Injectable } from '@nestjs/common';
import { v2 as cloudinary } from 'cloudinary';
import { CloudinaryResponse } from './cloudinary-response';
import * as streamifier from 'streamifier';

@Injectable()
export class CloudinaryService {
  uploadFile(file: Express.Multer.File, folder: string): Promise<CloudinaryResponse> {
    return new Promise((resolve, reject) => {
      const uploadStream = cloudinary.uploader.upload_stream(
        {
          folder: `my-bad-customer/${folder}`,
        },
        (error, result) => {
          if (error) return reject(error);
          if (!result) return reject(new Error('Cloudinary upload failed: Empty result'));
          resolve(result);
        },
      );

      streamifier.createReadStream(file.buffer).pipe(uploadStream);
    });
  }

  async deleteFile(publicId: string): Promise<any> {
    return new Promise((resolve, reject) => {
      cloudinary.uploader.destroy(publicId, (error, result) => {
        if (error) return reject(error);
        resolve(result);
      });
    });
  }
}
