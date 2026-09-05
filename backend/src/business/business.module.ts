import { Module } from '@nestjs/common';
import { BusinessService } from './business.service';
import { BusinessController } from './business.controller';
import { CloudinaryModule } from '../cloudinary/cloudinary.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [CloudinaryModule, AuthModule],
  controllers: [BusinessController],
  providers: [BusinessService],
  exports: [BusinessService],
})
export class BusinessModule {}
