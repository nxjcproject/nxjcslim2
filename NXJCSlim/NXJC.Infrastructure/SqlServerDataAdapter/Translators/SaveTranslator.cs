using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Translators
{
    public static class SaveTranslator
    {
        private static string baseInsert = "INSERT INTO ";
        private static string baseUpdate = "UPDATE ";

        /// <summary>
        /// 生成Insert语句
        /// </summary>
        /// <param name="insertObject"></param>
        /// <param name="command"></param>
        public static void TranslateIntoInsert<T>(Insert<T> insert, SqlCommand command)
        {
            StringBuilder sqlInsert = new StringBuilder();
            sqlInsert.Append(baseInsert);
            sqlInsert.Append(insert.TableName + " (");

            foreach (var item in insert.ExcludeField)
            {
                if (insert.Values.ContainsKey(item.Name))
                {
                    insert.Values.Remove(item.Name);
                }
            }

            foreach (var item in insert.Values)
            {
                sqlInsert.Append(item.Key + ",");
            }
            sqlInsert.Remove(sqlInsert.Length - 1, 1);
            sqlInsert.Append(") VALUES (");
            foreach (var item in insert.Values)
            {
                sqlInsert.Append("@I_" + item.Key + ",");
                command.Parameters.Add(ParameterDataNullHelper.ChangeNull("@I_" + item.Key, item.Value));
            }
            sqlInsert.Remove(sqlInsert.Length - 1, 1);
            sqlInsert.Append(")");

            command.CommandText = sqlInsert.ToString();
        }

        /// <summary>
        /// 生成Update语句
        /// </summary>
        /// <param name="updateObject"></param>
        /// <param name="command"></param>
        public static void TranslateIntoUpdate<T>(Update<T> update, SqlCommand command)
        {
            StringBuilder sqlUpdate = new StringBuilder();
            sqlUpdate.Append(baseUpdate);
            sqlUpdate.Append(update.TableName + " SET ");

            //删除字段
            foreach (var item in update.ExcludeField)
            {
                if (update.Values.ContainsKey(item.Name))
                {
                    update.Values.Remove(item.Name);
                }
            }
            //条件列也可能跟新
            //foreach (var item in update.Criterions)
            //{
            //    if (update.Vaules.ContainsKey(item.FieldName))
            //    {
            //        update.Vaules.Remove(item.FieldName);
            //    }
            //}

            foreach (var item in update.Values)
            {
                sqlUpdate.Append(item.Key + "=@U_" + item.Key + ",");
                command.Parameters.Add(ParameterDataNullHelper.ChangeNull("@U_" + item.Key, item.Value));
            }
            sqlUpdate.Remove(sqlUpdate.Length - 1, 1);

            TranslateHelper.GetCriterionString(sqlUpdate, update.Criterions, command, update.SqlOperator);

            command.CommandText = sqlUpdate.ToString();
        }
    }
}
