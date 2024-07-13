import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { TablesModule } from './tables/tables.module';
import { DepartmentsModule } from './departments/departments.module';
import { MenuModule } from './menu/menu.module';
import { BranchesModule } from './branches/branches.module';
import { CategoriesModule } from './categories/categories.module';
import { OrdersModule } from './orders/orders.module';

@Module({
    imports: [
        AuthModule,
        TablesModule,
        DepartmentsModule,
        MenuModule,
        BranchesModule,
        CategoriesModule,
        OrdersModule
    ],
    exports: [
        AuthModule,
        TablesModule,
        DepartmentsModule,
        MenuModule,
        BranchesModule,
        CategoriesModule,
        OrdersModule
    ],
})
export class ManagementModule {}
