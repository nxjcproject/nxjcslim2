using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    public class OrderByClause
    {
        private string _fieldName;
        private bool _desc;

        public string FieldName
        {
            get { return _fieldName; }
            set { _fieldName = value; }
        }
        public bool Desc
        {
            get { return _desc; }
            set { _desc = value; }
        }

        public OrderByClause(string fieldName, bool desc)
        {
            _fieldName = fieldName;
            _desc = desc;
        }
    }
}
