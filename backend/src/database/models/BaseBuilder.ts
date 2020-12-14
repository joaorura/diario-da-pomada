import { Model, Page, QueryBuilder } from 'objection';

class BaseBuilder<M extends Model, R = M[]> extends QueryBuilder<M, R> {
    SingleQueryBuilderType!: BaseBuilder<M, M>;
    ArrayQueryBuilderType!: BaseBuilder<M, M[]>;
    PageQueryBuilderType!: BaseBuilder<M, Page<M>>;
    NumberQueryBuilderType!: BaseBuilder<M, number>;
}

export default BaseBuilder;
