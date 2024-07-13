import { Module } from '@nestjs/common';
import { InvoicesService } from './services/invoices.service';
import { InvoicesController } from './controllers/invoices.controller';

@Module({
    imports: [],
    controllers: [InvoicesController],
    providers: [InvoicesService],
    exports: []
})
export class InvoicesModule {}
