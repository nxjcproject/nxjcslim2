using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    public class Criterion
    {
        private string _fieldName;
        private string _parameterName;
        private object _parameterValue;
        private CriteriaOperator _criteriaOperator;

        public Criterion(string fieldName, string parameterName, object parameterValue, CriteriaOperator criterriaOperator)
        {
            _fieldName = fieldName;
            _parameterName = parameterName;
            _parameterValue = parameterValue;
            _criteriaOperator = criterriaOperator;
        }
        public Criterion(string fieldName, object parameterValue, CriteriaOperator criterriaOperator)
        {
            _fieldName = fieldName;
            _parameterValue = parameterValue;
            _criteriaOperator = criterriaOperator;
        }

        public string FieldName
        {
            get { return _fieldName; }
        }

        public string ParameterName
        {
            get
            {
                if (_parameterName == "" || _parameterName == null)
                    return _fieldName;
                else
                    return _parameterName;
            }
        }

        public object ParameterValue
        {
            get { return _parameterValue; }
        }

        public CriteriaOperator CriteriaOperator
        {
            get { return _criteriaOperator; }
        }
    }

    public enum CriteriaOperator
    {
        Equal,
        NotEqual,
        LessThanOrEqual,
        LessThan,
        MoreThanOrEqual,
        MoreThan,
        Like,
        NotApplicable
    }
}
