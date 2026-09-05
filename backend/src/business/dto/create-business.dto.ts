import { IsNotEmpty, IsString, IsOptional, IsEnum, MinLength, MaxLength, IsNumberString } from 'class-validator';

export enum BusinessType {
  RETAIL = 'RETAIL',
  WHOLESALE = 'WHOLESALE',
  SERVICE = 'SERVICE',
  AGRICULTURE = 'AGRICULTURE',
  TRADING = 'TRADING',
  MANUFACTURING = 'MANUFACTURING',
  OTHER = 'OTHER',
}

export class CreateBusinessDto {
  @IsNotEmpty()
  @IsString()
  @MinLength(2)
  @MaxLength(200)
  businessName: string;

  @IsNotEmpty()
  @IsString()
  businessType: string;

  @IsOptional()
  @IsString()
  businessCategory?: string;

  @IsNotEmpty()
  @IsString()
  @MinLength(2)
  @MaxLength(100)
  ownerName: string;

  @IsNotEmpty()
  @IsString()
  @MinLength(10)
  @MaxLength(500)
  address: string;

  @IsNotEmpty()
  @IsString()
  city: string;

  @IsNotEmpty()
  @IsString()
  state: string;

  @IsNotEmpty()
  @IsNumberString()
  @MinLength(6)
  @MaxLength(6)
  pincode: string;

  @IsOptional()
  @IsString()
  @MinLength(15)
  @MaxLength(15)
  gstNumber?: string;

  @IsOptional()
  @IsString()
  @MinLength(10)
  @MaxLength(10)
  panNumber?: string;

  @IsOptional()
  @IsString()
  @MaxLength(1000)
  additionalInfo?: string;
}
