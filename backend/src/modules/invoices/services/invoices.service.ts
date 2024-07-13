import { Injectable } from '@nestjs/common';
import { mkdirSync, unlinkSync, writeFileSync } from 'fs';
import { makeId } from 'src/common/helpers/make-id';
import { join } from 'path';
import { createPDF } from './puppeter/create-pdf';
import {v2 as cloudinary} from 'cloudinary';
import * as streamifier from 'streamifier';

@Injectable()
export class InvoicesService {

    
    private readonly tempDocumentsPath = process.env.TEMP_DOCUMENTS_PATH ? process.env.TEMP_DOCUMENTS_PATH : './temp'
    private readonly defaultOptions = { 
        format: 'a4', 
        printBackground: true,
        margin: { left: '10mm', top: '10mm', right: '10mm', bottom: '10mm', }
    }

    private content: string =  `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice</title>
    </head>
    <body>
        <h1>Order invoice #{{orderNumber}}</h1>
        <h3>Order date: {{orderDate}}</h3>

        {{#items}}
            <div>
                <h4>{{name}}</h4>
                <p>Price: {{price}}</p>
                <p>Quantity: {{quantity}}</p>
                <p>Total: {{total}}</p>
            </div>
        {{/items}}

        <h3>Total: {{total}}</h3>
    </body>
    </html>`

    constructor () {
        mkdirSync(this.tempDocumentsPath, { recursive: true })
    }

    generator(content: string = this.content, data: any = null, options: any = this.defaultOptions, isHBS: boolean = false, returnType: any = 'pdf_buffer') {
        if (returnType == 'pdf_buffer') {
            return this.createPdf(content, { ...this.defaultOptions }, data, isHBS)
        }
    }

    private async createPdf(html: string, options: any, data: any = null, isHBS: boolean = false): Promise<Buffer> {
        let path = join(this.tempDocumentsPath, `${makeId(10)}-pdf.template.${isHBS ? 'hbs' : 'html'}`)
        writeFileSync(path, html.toString().replace(/\"/g, '"'))
        const PDF = await createPDF(path, options, data)
        unlinkSync(path)
        return PDF
    }

    uploadFile(file: any, folder: string): Promise<any> {
        return new Promise<any>((resolve, reject) => {
          const uploadStream = cloudinary.uploader.upload_stream({ folder: '' + folder},
            (error, result) => {
              if (error) return reject(error);
              resolve(result);
            },
          );
    
          streamifier.createReadStream(file).pipe(uploadStream);
        });
    }

}
