using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    public static class TranslateHelper
    {
        /// <summary>
        /// 通过SqlOperator获得操作符号（AND 和 OR）
        /// </summary>
        /// <param name="sqlOperator"></param>
        /// <returns></returns>
        public static string GetStringFromSqlOperator(SqlOperator sqlOperator)
        {
            switch (sqlOperator)
            {
                case SqlOperator.AND:
                    return " AND ";
                case SqlOperator.OR:
                    return " OR ";
                default:
                    throw new Exception("错误的连接操作符");
            }
        }

        /// <summary>
        /// 获得返回数据的行数字符串
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        public static string GetTopNumber(int number)
        {
            return "TOP " + number + " ";
        }

        /// <summary>
        /// 通过Criterion生成WHERE语句后的判断字符串
        /// </summary>
        /// <param name="criterion"></param>
        /// <returns></returns>
        public static string GetStringFromCriterion(Criterion criterion)
        {
            if (criterion.FieldName.Split('.').Count() == 1)
            {
                return String.Format("[{0}]{1}@{2}", criterion.FieldName, GetStringFromCriteriaOperater(criterion.CriteriaOperator), criterion.ParameterName);
            }
            else
            {
                return String.Format("[{0}].[{1}]{2}@{3}", criterion.FieldName.Split('.')[0], criterion.FieldName.Split('.')[1], GetStringFromCriteriaOperater(criterion.CriteriaOperator), criterion.ParameterName);
            }
        }

        /// <summary>
        /// 通过FuzzyCriterion生成WHERE语句后的判断字符串
        /// </summary>
        /// <param name="criterion"></param>
        /// <returns></returns>
        public static string GetFuzzyStringFromCriterion(Criterion criterion)
        {
            return String.Format("[{0}] LIKE '{1}'", criterion.FieldName, criterion.ParameterValue);
        }

        /// <summary>
        /// 通过CriteriaOperator获得判断符号（“=”，“<=”等）
        /// </summary>
        /// <param name="criteriaOperator"></param>
        /// <returns></returns>
        private static string GetStringFromCriteriaOperater(CriteriaOperator criteriaOperator)
        {
            switch (criteriaOperator)
            {
                case CriteriaOperator.Equal:
                    return "=";
                case CriteriaOperator.NotEqual:
                    return "!=";
                case CriteriaOperator.LessThanOrEqual:
                    return "<=";
                case CriteriaOperator.MoreThanOrEqual:
                    return ">=";
                case CriteriaOperator.LessThan:
                    return "<";
                case CriteriaOperator.MoreThan:
                    return ">";
                default:
                    throw new ApplicationException("No operator defined.");
            }
        }

        /// <summary>
        /// 生成排序条件字符串
        /// </summary>
        /// <param name="orderByClause"></param>
        /// <returns></returns>
        public static string GetStringFromOrderByClause(IList<OrderByClause> orderByClauses)
        {
            StringBuilder result = new StringBuilder();
            result.Append(" ORDER BY");
            foreach (OrderByClause item in orderByClauses)
            {
                string itemString = String.Format(" [{0}] {1},", item.FieldName, item.Desc ? "DESC" : "ASC");
                result.Append(itemString);
            }
            result.Remove(result.Length - 1, 1);
            return result.ToString();
        }

        /// <summary>
        /// 生成字段字符串
        /// </summary>
        /// <param name="needField"></param>
        /// <returns></returns>
        public static string GetFieldString(NeedField needField)
        {
            return String.Format("{0}.[{1}] AS {2},", needField.TableName, needField.FieldName, needField.VariableName);
        }

        /// <summary>
        /// 获得查询条件字符串
        /// </summary>
        /// <param name="stringBuilder"></param>
        /// <param name="criterions"></param>
        /// <param name="command"></param>
        /// <param name="sqlOperator"></param>
        public static void GetCriterionString(StringBuilder stringBuilder, IEnumerable<Criterion> criterions, SqlCommand command, SqlOperator sqlOperator)
        {
            bool _isNotfirstFilterClause = false;
            if (criterions.Count() >= 1)
            {
                stringBuilder.Append(" WHERE ");
                foreach (var item in criterions)
                {
                    if (item.CriteriaOperator != CriteriaOperator.Like)
                    {
                        if (_isNotfirstFilterClause == true)
                        {
                            stringBuilder.Append(TranslateHelper.GetStringFromSqlOperator(sqlOperator));
                        }
                        stringBuilder.Append(TranslateHelper.GetStringFromCriterion(item));
                        command.Parameters.Add(ParameterDataNullHelper.ChangeNull("@" + item.ParameterName, item.ParameterValue));

                        _isNotfirstFilterClause = true;
                    }
                    else
                    {
                        if (_isNotfirstFilterClause == true)
                        {
                            stringBuilder.Append(TranslateHelper.GetStringFromSqlOperator(sqlOperator));
                        }
                        stringBuilder.Append(TranslateHelper.GetFuzzyStringFromCriterion(item));
                        //command.Parameters.Add(ParameterDataNullHelper.ChangeNull("@" + item.ParameterName, item.ParameterValue));

                        _isNotfirstFilterClause = true;
                    }
                }

                _isNotfirstFilterClause = false;
            }
        }
        /// <summary>
        /// 生成连接表条件字符串
        /// </summary>
        /// <returns></returns>
        public static string GetJoinConditionString(IEnumerable<NeedField> needFields, JoinCriterion joinCriterion)
        {
            StringBuilder result = new StringBuilder();

            IDictionary<int, string> tableName = new Dictionary<int, string>();
            int index = 0;
            foreach (var item in needFields)    //去除重复的数据库表名
            {
                if (!tableName.Values.Contains(item.TableName))
                {
                    tableName.Add(index, item.TableName);
                    index++;
                }
            }
            if (tableName.Keys.Count() == 1)
            {
                return " FROM " + tableName[0];
            }

            if (tableName.Keys.Count() > 1)
            {
                result.Append(" FROM ").Append(tableName[0]);

                if (joinCriterion.DefaultJoinFieldName == "" || joinCriterion.DefaultJoinFieldName == null)
                {
                    if (tableName.Keys.Count() != joinCriterion.JoinFieldDictionary.Keys.Count())
                    {
                        throw new KeyNotFoundException("连接的表数目和字段数目不一致");
                    }

                    for (int itemNo = 1; itemNo < index; itemNo++)
                    {
                        result.Append(String.Format(" {0} {1} ON {2}.[{3}]={4}.[{5}]",
                            GetJoinType(joinCriterion), tableName[itemNo], tableName[0],
                            joinCriterion.JoinFieldDictionary[tableName[0]], tableName[itemNo], joinCriterion.JoinFieldDictionary[tableName[itemNo]]));
                    }
                }
                else
                {
                    for (int itemNo = 1; itemNo < index; itemNo++)
                    {
                        if (joinCriterion.DefaultJoinFieldName != "" || joinCriterion.DefaultJoinFieldName != null)
                            result.Append(String.Format(" {0} {1} ON {2}.[{3}]={4}.[{5}]",
                                GetJoinType(joinCriterion), tableName[itemNo], tableName[0],
                                joinCriterion.DefaultJoinFieldName, tableName[itemNo], joinCriterion.DefaultJoinFieldName));
                    }
                }
            }
            else
            {
                throw new Exception("连接字符串生产错误");
            }

            return result.ToString();
        }

        /// <summary>
        /// 获得连接方式
        /// </summary>
        /// <param name="joinCriterion"></param>
        /// <returns></returns>
        private static string GetJoinType(JoinCriterion joinCriterion)
        {
            switch (joinCriterion.JoinType)
            {
                case JoinType.JOIN:
                    return "JOIN";
                case JoinType.INNER_JOIN:
                    return "INNER JOIN";
                case JoinType.LEFT_JOIN:
                    return "LEFT JOIN";
                case JoinType.RIGHT_JOIN:
                    return "RIGHT JOIN";
                case JoinType.FULL_JOIN:
                    return "FULL JOIN";
                default:
                    throw new Exception("没有对应的连接方式");
            }
        }
    }
}
