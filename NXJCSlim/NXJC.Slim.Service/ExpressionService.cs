using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class ExpressionService
    {
        /// <summary>
        /// 验证表达式合法性
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        public static string[] ValidateExpression(string expression)
        {
            List<string> result = new List<string>();
            foreach (var exception in ExpressionHelper.Utility.ValidateExpression(expression))
            {
                result.Add(exception.Message);
            }

            return result.ToArray();
        }

        /// <summary>
        /// 按分厂ID获取所有公式组
        /// </summary>
        /// <param name="factoryId"></param>
        /// <returns></returns>
        public static DataTable GetFormulaGroupsByFactoryId(int factoryId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("FormulaGroup");
            query.AddCriterion("FactoryID", factoryId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }

        /// <summary>
        /// 获取生效中的公式组
        /// </summary>
        /// <param name="factoryId"></param>
        /// <returns></returns>
        public static DataTable GetFormulaGroupsEffectived(int factoryId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  FormulaLog.*, FormulaGroup.*
                                        FROM    FormulaGroup INNER JOIN
                                                FormulaLog ON FormulaGroup.KeyID = FormulaLog.GroupID
                                        WHERE   (FormulaGroup.FactoryID = @factoryId) AND ((FormulaLog.EffectiveDate < { fn NOW() }) AND (FormulaLog.ExpirationDate IS NULL) OR
                                                                                           (FormulaLog.EffectiveDate < { fn NOW() }) AND (FormulaLog.ExpirationDate > { fn NOW() })
                                                )";

                command.Parameters.Add(new SqlParameter("factoryId", factoryId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        /// <summary>
        /// 获取即将生效的公式组
        /// </summary>
        /// <param name="factoryId"></param>
        /// <returns></returns>
        public static DataTable GetFormulaGroupsPendingEffectived(int factoryId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  FormulaLog.*, FormulaGroup.*
                                        FROM    FormulaGroup INNER JOIN
                                                FormulaLog ON FormulaGroup.KeyID = FormulaLog.GroupID
                                        WHERE   (FormulaGroup.FactoryID = @factoryId) AND (FormulaLog.EffectiveDate > { fn NOW() })";

                command.Parameters.Add(new SqlParameter("factoryId", factoryId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        /// <summary>
        /// 获取即将过期的公式组
        /// </summary>
        /// <param name="factoryId"></param>
        /// <returns></returns>
        public static DataTable GetFormulaGroupsPendingExpiration(int factoryId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  FormulaLog.*, FormulaGroup.*
                                        FROM    FormulaGroup INNER JOIN
                                                FormulaLog ON FormulaGroup.KeyID = FormulaLog.GroupID
                                        WHERE   (FormulaGroup.FactoryID = @factoryId) AND (FormulaLog.ExpirationDate > { fn NOW() })";

                command.Parameters.Add(new SqlParameter("factoryId", factoryId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        /// <summary>
        /// 按公式组ID获取所有公式
        /// </summary>
        /// <param name="groupId"></param>
        /// <returns></returns>
        public static DataTable GetFormulasByGroupId(Guid groupId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("Formula");
            query.AddCriterion("GroupID", groupId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            query.OrderByClause = new SqlServerDataAdapter.Infrastruction.OrderByClause("LevelCode", false);

            return factory.Query(query);
        }

        /// <summary>
        /// 按公式组ID获取公式组信息
        /// </summary>
        /// <param name="groupId"></param>
        /// <returns></returns>
        public static DataTable GetFormulaGroupInfoByGroupId(Guid groupId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("FormulaGroup");
            query.AddCriterion("KeyID", groupId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }

        /// <summary>
        /// 按分厂ID新建公式组
        /// </summary>
        /// <param name="factoryId"></param>
        public static Guid CreateNewFormulaGroup(int factoryId)
        {
            Guid id = Guid.NewGuid();

            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "INSERT INTO FormulaGroup (KeyID, FactoryID, Name, CreateDate, State) VALUES ('" + id.ToString() + "', " + factoryId + ", '新公式组', '" + DateTime.Now.ToString() + "', 1)"; 

                connection.Open();
                command.ExecuteNonQuery();
            }

            return id;
        }

        /// <summary>
        /// 更新公式组名称
        /// </summary>
        /// <param name="groupId"></param>
        /// <param name="name"></param>
        public static void SaveFormulaGroupName(Guid groupId, string name)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "UPDATE FormulaGroup SET Name = '" + name + "' WHERE KeyID = '" + groupId.ToString() + "'";

                connection.Open();
                command.ExecuteNonQuery();

            }
        }

        /// <summary>
        /// 保存公式
        /// </summary>
        /// <param name="groupId"></param>
        /// <param name="data"></param>
        public static void SaveFormulas(Guid groupId, DataTable data)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            // 删除现存公式
            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Delete delete = new Delete("Formula");
            delete.AddCriterions("GroupID", groupId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            factory.Remove(delete);
            
            // 插入所有公式
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();

                connection.Open();
                foreach (DataRow row in data.Rows)
                {
                    command.CommandText = "INSERT INTO Formula (GroupID, LevelCode, Name, Formula) VALUES ('" + groupId.ToString() + "', '" + row["LevelCode"].ToString() + "','" + row["Name"].ToString() + "','" + row["Formula"].ToString() + "')";
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
