using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    public class ParameterDataNullHelper
    {
        public static SqlParameter ChangeNull(string parameter, object value)
        {
            if (value == null)
            {
                return new SqlParameter(parameter, DBNull.Value);
            }
            else
            {
                return new SqlParameter(parameter, value);
            }
        }
    }
}
