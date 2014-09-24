using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public class Delete
    {
        private string _tableName;
        private IList<Criterion> _criterions;
        private SqlOperator _sqlOperator;

        public Delete(string tableName, IList<Criterion> criterions, SqlOperator sqlOperator)
        {
            _tableName = tableName;
            _criterions = criterions;
            _sqlOperator = sqlOperator;
        }

        public Delete(string tableName)
        {
            _tableName = tableName;
            _criterions = new List<Criterion>();
        }

        private Delete()
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

        public void AddCriterions(string propertyName, string parameterName,
            object parameterValue, CriteriaOperator criterriaOperator)
        {
            _criterions.Add(new Criterion(propertyName, parameterName, parameterValue, criterriaOperator));
        }

        public void AddCriterions(string propertyName, object parameterValue, CriteriaOperator criterriaOperator)
        {
            _criterions.Add(new Criterion(propertyName, parameterValue, criterriaOperator));
        }

        public void AddCriterions(Criterion criterion)
        {
            _criterions.Add(criterion);
        }

        public void AddSqlOperator(SqlOperator sqlOperator)
        {
            _sqlOperator = sqlOperator;
        }
    }
}
