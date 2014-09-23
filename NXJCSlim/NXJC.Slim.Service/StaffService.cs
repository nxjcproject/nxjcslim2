using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class StaffService
    {
        /// <summary>
        /// 按生产线ID获取班组
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetWorkingTeamByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("WorkingTeam");
            query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }

        /// <summary>
        /// 按班组ID获取负责人
        /// </summary>
        /// <param name="workingTeamId"></param>
        /// <returns></returns>
        public static DataTable GetChargeManByWorkingTeamId(int workingTeamId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT StaffInfo.ID, StaffInfo.Name FROM StaffInfo INNER JOIN WorkingTeam ON StaffInfo.ID = WorkingTeam.ChargeManID WHERE (WorkingTeam.ID = " + workingTeamId + ")";

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        /// <summary>
        /// 获取员工信息
        /// </summary>
        /// <returns></returns>
        public static DataTable GetStaffInfo()
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("StaffInfo");

            return factory.Query(query);
        }
    }
}
