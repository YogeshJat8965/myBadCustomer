import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { Role, VerificationStatus } from '../src/common/enums/prisma-enums';

const prisma = new PrismaClient();

async function main() {
  console.log('Start seeding...');
  
  // Create admin user
  const adminEmail = 'admin@mybadcustomer.com';
  const existingAdmin = await prisma.user.findUnique({ where: { email: adminEmail } });
  
  if (!existingAdmin) {
    const hashedPassword = await bcrypt.hash('Admin@123456', 12);
    const admin = await prisma.user.create({
      data: {
        fullName: 'System Administrator',
        email: adminEmail,
        phone: '0000000000',
        password: hashedPassword,
        role: Role.ADMIN,
        verificationStatus: VerificationStatus.APPROVED,
        isActive: true,
      },
    });
    console.log(`Created admin user with id: ${admin.id}`);
  } else {
    console.log('Admin user already exists.');
  }

  console.log('Seeding finished.');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
