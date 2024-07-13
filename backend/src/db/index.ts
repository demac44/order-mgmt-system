import { BranchesEntity } from "./entities/branches/BranchesEntity";
import { DepartmentsEntity } from "./entities/departments/DepartmentsEntity";
import { CategoriesEntity } from "./entities/menu/CategoriesEntity";
import { MenuEntity } from "./entities/menu/MenuEntity";
import { MenuItemsEntity } from "./entities/menu/MenuItemsEntity";
import { MenuItemsImagesEntity } from "./entities/menu/MenuItemsImagesEntity";
import { OrdersEntity } from "./entities/orders/OrdersEntity";
import { OrdersItemsEntity } from "./entities/orders/OrdersItemsEntity";
import { OrdersStatusEntity } from "./entities/orders/OrdersStatusEntity";
import { TablesEntity } from "./entities/tables/TablesEntity";
import { UsersEntity } from "./entities/users/UsersEntity";
import { UsersRolesEntity } from "./entities/users/UsersRolesEntity";
import { UsersSessionsEntity } from "./entities/users/UsersSessionsEntity";



export const entities = [
    DepartmentsEntity,
    BranchesEntity,
    CategoriesEntity,
    MenuEntity,
    MenuItemsEntity,
    MenuItemsImagesEntity,
    OrdersEntity,
    OrdersItemsEntity,
    OrdersStatusEntity,
    TablesEntity,
    UsersEntity,
    UsersRolesEntity,
    UsersSessionsEntity
];


export {
    DepartmentsEntity,
    BranchesEntity,
    CategoriesEntity,
    MenuEntity,
    MenuItemsEntity,
    MenuItemsImagesEntity,
    OrdersEntity,
    OrdersItemsEntity,
    OrdersStatusEntity,
    TablesEntity,
    UsersEntity,
    UsersRolesEntity,
    UsersSessionsEntity
}