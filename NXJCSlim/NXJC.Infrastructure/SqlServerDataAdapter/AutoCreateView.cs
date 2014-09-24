using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter
{
    public class AutoCreateView
    {
        private string _connectionString;
        private JoinCriterion _joinCriterion;

        private IEnumerable<NeedField> _needFields;

        public AutoCreateView(string connectionString, IEnumerable<NeedField> needFields, JoinCriterion joinCriterion)
        {
            _connectionString = connectionString;
            _needFields = needFields;
            _joinCriterion = joinCriterion;
        }

        /// <summary>
        /// 创建视图
        /// </summary>
        /// <param name="viewName"></param>
        public void CreateView(string viewName)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                conn.Open();

                DropView(viewName, cmd);

                GetBulidViewString(viewName, cmd);

                cmd.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// 生成创建视图SQL语句
        /// </summary>
        /// <param name="viewName"></param>
        /// <param name="command"></param>
        private void GetBulidViewString(string viewName, SqlCommand command)
        {
            string baseString = "CREATE VIEW ";
            StringBuilder result = new StringBuilder();
            result.Append(baseString);
            result.Append(viewName);
            result.Append(" AS SELECT ");

            foreach (var item in _needFields)
            {
                result.Append(TranslateHelper.GetFieldString(item));
            }
            result.Remove(result.Length - 1, 1);

            result.Append(" FROM ");
            result.Append(TranslateHelper.GetJoinConditionString(_needFields, _joinCriterion));

            command.Parameters.Clear();
            command.CommandText = result.ToString();
        }

        /// <summary>
        /// 删除视图
        /// </summary>
        /// <param name="viewName"></param>
        /// <param name="command"></param>
        private void DropView(string viewName, SqlCommand command)
        {
            string dropString = "DROP VIEW " + viewName;
            string selectString = "SELECT COUNT(*) FROM sys.all_views WHERE name=@name";

            command.CommandText = selectString;
            command.Parameters.Add(new SqlParameter("@name", viewName));

            int result = 0;
            int.TryParse(command.ExecuteScalar().ToString(), out result);

            if (result >= 1)
            {
                command.CommandText = dropString;
                command.ExecuteNonQuery();
            }
        }
    }
}
