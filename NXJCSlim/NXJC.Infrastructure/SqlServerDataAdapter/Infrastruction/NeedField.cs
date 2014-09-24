using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    public class NeedField
    {
        public string TableName { get; set; }
        public string FieldName { get; set; }
        //public string VariableName { get; set; }

        private string _variableName;
        public string VariableName
        {
            get
            {
                if (_variableName == null || _variableName == "")
                    return FieldName;
                else
                    return _variableName;
            }
            set { _variableName = value; }
        }
    }
}
