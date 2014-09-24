using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Translators
{
    public static class ComplexQueryTranslator
    {
        public static void TranslateIntoComplexQuery(ComplexQuery complexQuery, SqlCommand command)
        {
            string baseString = "SELECT ";
            StringBuilder result = new StringBuilder();
            result.Append(baseString);

            if (complexQuery.IsDictinct == true)
            {
                result.Append("DISTINCT ");
            }

            if (complexQuery.TopNumber!= 0)
            {
                result.Append(TranslateHelper.GetTopNumber(complexQuery.TopNumber));
            }

            foreach (var item in complexQuery.NeedFields)
            {
                result.Append(TranslateHelper.GetFieldString(item));
            }
            result.Remove(result.Length - 1, 1);

            result.Append(TranslateHelper.GetJoinConditionString(complexQuery.NeedFields, complexQuery.JoinCriterion));

            if (complexQuery.Criterions.Count() > 0)
            {
                TranslateHelper.GetCriterionString(result, complexQuery.Criterions, command, complexQuery.SqlOperator);
            }

            if (complexQuery.OrderByClauses.Count > 0)
            {
                result.Append(TranslateHelper.GetStringFromOrderByClause(complexQuery.OrderByClauses));
            }

            command.CommandText = result.ToString();

        }
    }
}
