using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Translators
{
    public static class DeleteTranslator
    {
        private static string baseDelete = "DELETE FROM ";
        private static string baseTruncate = "TRUNCATE TABLE ";

        /// <summary>
        /// 生成Delete语句
        /// </summary>
        /// <param name="deleteObject"></param>
        /// <param name="command"></param>
        public static void TranslateIntoDelete(Delete delete, SqlCommand command)
        {
            StringBuilder deleteString = new StringBuilder();
            deleteString.Append(baseDelete);
            deleteString.Append(delete.TableName);

            TranslateHelper.GetCriterionString(deleteString, delete.Criterions, command, delete.SqlOperator);

            command.CommandText = deleteString.ToString();
        }

        /// <summary>
        /// 生成Truncate语句
        /// </summary>
        /// <param name="deleteObject"></param>
        /// <param name="command"></param>
        public static void TranslatorIntoTruncate(Delete delete, SqlCommand command)
        {
            StringBuilder truncateString = new StringBuilder();
            truncateString.Append(baseTruncate);
            truncateString.Append(delete.TableName);
            command.CommandText = truncateString.ToString();
        }
    }
}
