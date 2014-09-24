using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public class Update<T>
    {
        private string _tableName;
        private IDictionary<string, object> _values;
        private IList<Criterion> _criterions;
        private SqlOperator _sqlOperator;
        private IList<ExcludeField> _excludeField; //不需要更新的字段

        public Update(string tableName, T values, IList<Criterion> criterions,SqlOperator sqlOperator, IList<ExcludeField> excludeField)
        {
            _tableName = tableName;
            _values = ConvertToDictionary.ConvertTo<T>(values);
            _criterions = criterions;
            _sqlOperator = sqlOperator;
            _excludeField = excludeField;
        }

        public Update(string tableName)
        {
            _tableName = tableName;
            _values = new Dictionary<string, object>();
            _criterions = new List<Criterion>();
            _excludeField = new List<ExcludeField>();
        }

        public Update(string tableName, T values)
        {
            _tableName = tableName;
            _values = ConvertToDictionary.ConvertTo<T>(values);
            _criterions = new List<Criterion>();
            _excludeField = new List<ExcludeField>();
        }

        private Update()
        { }

        public string TableName
        {
            get { return _tableName; }
        }
        public IDictionary<string, object> Values
        {
            get { return _values; }
            //set { _values = value; }
        }
        public IList<ExcludeField> ExcludeField
        {
            get { return _excludeField; }
            set { _excludeField = value; }
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

        public void AddValues(T values)
        {
            _values = ConvertToDictionary.ConvertTo<T>(values);
        }

        public void AddCriterion(string fieldName, string parameterName,
            object parameterValue, CriteriaOperator criterriaOperator)
        {
            _criterions.Add(new Criterion(fieldName, parameterName, parameterValue, criterriaOperator));
        }

        public void AddCriterion(string fieldName, object parameterValue, CriteriaOperator criterriaOperator)
        {
            _criterions.Add(new Criterion(fieldName, parameterValue, criterriaOperator));
        }

        public void AddCriterion(Criterion criterion)
        {
            _criterions.Add(criterion);
        }

        public void AddSqlOperator(SqlOperator sqlOperator)
        {
            _sqlOperator = sqlOperator;
        }

        public void AddExcludeField(ExcludeField excludeField)
        {
            _excludeField.Add(excludeField);
        }
        public void AddExcludeField(string fieldName)
        {
            _excludeField.Add(new ExcludeField
            {
                Name = fieldName
            });
        }
    }
}
