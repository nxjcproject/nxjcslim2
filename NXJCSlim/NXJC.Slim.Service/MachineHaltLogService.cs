using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class MachineHaltLogService
    {        
        /// <summary>
        /// 获取设备停机原因字典
        /// </summary>
        /// <returns></returns>
        public static DataTable GetMachineHaltReason()
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("MachineHaltReason");

            return factory.Query(query);
        }

        /// <summary>
        /// 获取停机记录
        /// </summary>
        /// <param name="productLineId"></param>
        /// <param name="start"></param>
        /// <param name="end"></param>
        /// <returns></returns>
        public static DataTable GetHaltLog(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("MachineHaltLog");

            return factory.Query(query);
        }

        /// <summary>
        /// 按起始时间段获取停机记录
        /// </summary>
        /// <param name="productLineId"></param>
        /// <param name="start"></param>
        /// <param name="end"></param>
        /// <returns></returns>
        public static DataTable GetHaltLog(int productLineId, DateTime start)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("MachineHaltLog");
            query.AddCriterion("HaltTime", start, SqlServerDataAdapter.Infrastruction.CriteriaOperator.MoreThanOrEqual);

            return factory.Query(query);
        }
    }
}
