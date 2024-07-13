import { Column, Entity, JoinColumn, ManyToOne, PrimaryColumn } from "typeorm";
import { UsersEntity } from "./UsersEntity";

@Entity('users_sessions')
export class UsersSessionsEntity {
    @PrimaryColumn({ name: 'session_id', type: 'varchar', length: 50 })
    id: string

    @Column({ name: 'user_id', type: 'bigint', nullable: true})
    userId: number

    @Column({ name: 'payload', type: 'json', default: {}})
    payload: { __cookie?: any, __private?: { [key: string]: any }, __type?: 'admin-session', [key: string]: any }

    @Column({ name: 'files', type: 'json', default: {}})
    files: { [key: string]: { originalName: string, mimeType: string, storagePath: string, extension: string, tempKey: string, contentType: string, size?: number } }

    @Column({ name: 'expired_at', type: 'bigint', nullable: false})
    expiredAt: number

    @Column({ name: 'destroyed_at', type: 'bigint', nullable: true})
    destroyedAt: number

    @ManyToOne(() => UsersEntity)
    @JoinColumn({ referencedColumnName: 'id', name: 'user_id' })
    user: UsersEntity
}