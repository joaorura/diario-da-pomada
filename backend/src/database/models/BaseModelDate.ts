import BaseModel from './BaseModel';

class BaseModelDate extends BaseModel {
    createdAt: Date;
    updatedAt: Date;
    $beforeInsert(): void {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    $beforeUpdate(): void {
        this.updatedAt = new Date();
    }
}

export default BaseModelDate;
