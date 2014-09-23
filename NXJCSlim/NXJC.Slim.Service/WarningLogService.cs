using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class DCSWarningLogService
    {
        /// <summary>
        /// 获取报警记录
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetWarningLog(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("DCSWarningLog");

            return factory.Query(query);
        }

        /// <summary>
        /// 按起始时间段获取报警记录
        /// </summary>
        /// <param name="productLineId"></param>
        /// <param name="start"></param>
        /// <param name="end"></param>
        /// <returns></returns>
        public static DataTable GetWarningLog(int productLineId, DateTime start)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("DCSWarningLog");
            query.AddCriterion("WarningTime", start, SqlServerDataAdapter.Infrastruction.CriteriaOperator.MoreThanOrEqual);

            return factory.Query(query);
        }
    }
}
