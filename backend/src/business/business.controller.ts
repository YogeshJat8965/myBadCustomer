import {
  Controller,
  Post,
  Body,
  Get,
  Put,
  UseGuards,
  UseInterceptors,
  UploadedFile,
  ParseFilePipe,
  MaxFileSizeValidator,
  FileTypeValidator,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { BusinessService } from './business.service';
import { CreateBusinessDto } from './dto/create-business.dto';
import { UpdateBusinessDto } from './dto/update-business.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators/current-user.decorator';

@Controller('business')
@UseGuards(JwtAuthGuard)
export class BusinessController {
  constructor(private readonly businessService: BusinessService) {}

  @Post()
  @UseInterceptors(FileInterceptor('proof'))
  async createBusiness(
    @CurrentUser() user: any,
    @Body() createBusinessDto: CreateBusinessDto,
    @UploadedFile(
      new ParseFilePipe({
        validators: [
          new MaxFileSizeValidator({ maxSize: 5 * 1024 * 1024 }), // 5MB
          new FileTypeValidator({ fileType: '.(png|jpeg|jpg|pdf)' }),
        ],
        fileIsRequired: false,
      }),
    )
    file?: Express.Multer.File,
  ) {
    return this.businessService.createBusiness(user.id, createBusinessDto, file);
  }

  @Get('my')
  async getMyBusiness(@CurrentUser() user: any) {
    return this.businessService.getMyBusiness(user.id);
  }

  @Put('update')
  async updateBusiness(
    @CurrentUser() user: any,
    @Body() updateBusinessDto: UpdateBusinessDto,
  ) {
    return this.businessService.updateBusiness(user.id, updateBusinessDto);
  }

  @Post('proof')
  @UseInterceptors(FileInterceptor('proof'))
  async uploadProof(
    @CurrentUser() user: any,
    @UploadedFile(
      new ParseFilePipe({
        validators: [
          new MaxFileSizeValidator({ maxSize: 5 * 1024 * 1024 }),
          new FileTypeValidator({ fileType: '.(png|jpeg|jpg|pdf)' }),
        ],
      }),
    )
    file: Express.Multer.File,
  ) {
    return this.businessService.uploadProof(user.id, file);
  }
}
