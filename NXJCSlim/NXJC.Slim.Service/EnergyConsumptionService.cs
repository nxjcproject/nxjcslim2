using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class EnergyConsumptionService
    {
        /// <summary>
        /// 按生产线ID获取所电耗报警设置
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetElectricityConsumptionAlarmSettingsByFactoryId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("ElectricityConsumptionAlarmParameterSetting");
            query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }

        /// <summary>
        /// 按生产线ID获取所煤耗报警设置
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetCoalConsumptionAlarmSettingsByFactoryId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("CoalConsumptionAlarmParameterSetting");
            query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }
    }
}
