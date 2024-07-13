import { Body, Controller, Post, Res } from '@nestjs/common';
import { Response } from 'express';
import { InvoicesService } from '../services/invoices.service';

@Controller('invoices')
export class InvoicesController {

    constructor(
        private readonly invoicesService: InvoicesService
    ){}


    @Post('/pdf')
    async generatePdfFromHtmlOrHBS(
        @Body() pdfToGenerate: any,
        @Res() response: Response
    ) {
        response.setHeader('content-type','application/pdf')
        response.end(await this.invoicesService.generator(pdfToGenerate.pdf.content, pdfToGenerate.pdf.data, pdfToGenerate.pdf.options, pdfToGenerate.pdf.isHBS, pdfToGenerate.returnType))
    }


}
