import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { NestExpressApplication } from '@nestjs/platform-express';
import * as cookieParser from 'cookie-parser';
import { corsConfig } from './common/cors/config';
// import { corsConfig } from './common/cors/config';
import { v2 as cloudinary } from 'cloudinary';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.use(cookieParser(process.env.SESSION_SECRET))
  
  app.setGlobalPrefix(`/api`)

  app.enableCors(corsConfig)

    cloudinary.config({ 
    cloud_name: 'dq5s8yqae', 
    api_key: '612996359637128', 
    api_secret: 'szixv1qj-OLbEnw91GltLKnOiEo' 
  });

  await app.listen(process.env.PORT || 5000);
}
bootstrap();
