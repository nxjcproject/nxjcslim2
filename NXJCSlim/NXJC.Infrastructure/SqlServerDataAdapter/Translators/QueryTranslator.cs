using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Translators
{
    public class QueryTranslator
    {
        private static string baseSelect = "SELECT * FROM ";

        /// <summary>
        /// 生成查询语句
        /// </summary>
        /// <param name="query"></param>
        /// <param name="command"></param>
        public static void TranslateIntoSelect(Query query, SqlCommand command)
        {
            StringBuilder selectString = new StringBuilder();
            selectString.Append(baseSelect);
            selectString.Append(query.TableName);

            TranslateHelper.GetCriterionString(selectString, query.Criterions, command, query.SqlOperator);

            if (query.OrderByClauses.Count() > 0)
            {
                selectString.Append(TranslateHelper.GetStringFromOrderByClause(query.OrderByClauses));
            }

            command.CommandText = selectString.ToString();
        }
    }
}
