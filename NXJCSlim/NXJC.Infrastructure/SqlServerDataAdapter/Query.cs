using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public class Query
    {
        private string _tableName;
        private IList<Criterion> _criterions;
        private SqlOperator _sqlOperator;
        private IList<OrderByClause> _orderByClauses;

        public Query(string tableName, IList<Criterion> criterions,
            SqlOperator sqlOperator, IList<OrderByClause> orderByClause)
        {
            _tableName = tableName;
            _criterions = criterions;
            _sqlOperator = sqlOperator;
            _orderByClauses = orderByClause;
        }

        public Query(string tableName)
        {
            _tableName = tableName;
            _criterions = new List<Criterion>();
            _orderByClauses = new List<OrderByClause>();
        }

        private Query()
        { }

        public string TableName
        {
            get { return _tableName; }
        }

        public IEnumerable<Criterion> Criterions
        {
            get { return _criterions; }
            set { _criterions = value.ToList(); }
        }

        public SqlOperator SqlOperator
        {
            get { return _sqlOperator; }
            set { _sqlOperator = value; }
        }

        public IList<OrderByClause> OrderByClauses
        {
            get { return _orderByClauses; }
            set { _orderByClauses = value; }
        }

        public void AddCriterion(string fieldName, string parameterName, object parameterValue, CriteriaOperator criteriaOperator)
        {
            _criterions.Add(new Criterion(fieldName, parameterName, parameterValue, criteriaOperator));
        }

        public void AddCriterion(string fieldName, object parameterValue, CriteriaOperator criteriaOperator)
        {
            _criterions.Add(new Criterion(fieldName, parameterValue, criteriaOperator));
        }

        public void AddCriterion(Criterion criterion)
        {
            _criterions.Add(criterion);
        }

        public void AddSqlOperator(SqlOperator sqlOperator)
        {
            _sqlOperator = sqlOperator;
        }

        /// <summary>
        /// 必要时使用字段的全称（表名加字段名）
        /// </summary>
        /// <param name="orderByClause"></param>
        public void AddOrderByClause(OrderByClause orderByClause)
        {
            _orderByClauses.Add(orderByClause);
        }
    }
}
