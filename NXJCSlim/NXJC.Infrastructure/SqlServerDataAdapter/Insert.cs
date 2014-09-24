using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public class Insert<T>
    {
        private string _tableName;
        private IDictionary<string, object> _values;
        private IList<ExcludeField> _excludeField; //不需要添加的字段

        public Insert(string tableName, T values, IList<ExcludeField> excludeField)
        {
            _tableName = tableName;
            _values = ConvertToDictionary.ConvertTo<T>(values);
            _excludeField = excludeField;
        }

        public Insert(string tableName, T values)
        {
            _tableName = tableName;
            _values = ConvertToDictionary.ConvertTo<T>(values);
            _excludeField = new List<ExcludeField>();
        }

        public Insert(string tableName)
        {
            _tableName = tableName;
            _values = new Dictionary<string, object>();
            _excludeField = new List<ExcludeField>();
        }

        private Insert()
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

        public void AddValues(T values)
        {
            _values = ConvertToDictionary.ConvertTo<T>(values);
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
