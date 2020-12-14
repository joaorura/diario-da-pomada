import { Model } from 'objection';
import BaseBuilder from './BaseBuilder';

class BaseModel extends Model {
    static useLimitInFirst = true;
    static modelPaths = [__dirname];
    static QueryBuilder = BaseBuilder;
    QueryBuilderType!: BaseBuilder<this>;
}

export default BaseModel;
