using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SqlServerDataAdapter;
using System.Data;
using NXJC.Infrastructure.Configuration;
using EasyUIJsonParser;

namespace NXJC.Slim.Service
{
    public class MeterDataDisplayService
    {
        private ISqlServerDataFactory dataFactory;

        public MeterDataDisplayService()
        {
            string connectionString = ConnectionStringFactory.NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(connectionString);
        }
        /// <summary>
        /// 获得分厂ID和名字
        /// </summary>
        /// <returns></returns>
        public string GetFactory()
        {
            ComplexQuery query = new ComplexQuery();
            query.AddNeedField("Factory", "ID");
            query.AddNeedField("Factory", "Name");
            DataTable dt = dataFactory.Query(query);

            if (dt.Rows.Count == 0)
                throw new Exception("查无数据");
            return ComboboxJsonParser.DataTableToJson(dt, "ID", "Name");
        }

        public string GetEletricalRoom(int factoryId)
        {
            try
            {
                string connString = ConnectionStringFactory.GetConnectionStringByFactoryID(factoryId, DatabaseType.EnergyDatabase);
                ISqlServerDataFactory factory = new SqlServerDataFactory(connString);

                ComplexQuery query = new ComplexQuery();
                query.AddNeedField("ElectricalRoom", "ID");
                query.AddNeedField("ElectricalRoom", "Name");
                DataTable dt = factory.Query(query);

                return ComboboxJsonParser.DataTableToJson(dt, "ID", "Name");
            }
            catch
            {
                return "[]";
            }
        }

        public static DataTable GetAmmetersByFactoryId(int factoryId)
        {
            string connectionString = ConnectionStringFactory.NXJCConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("AmmeterContrast");

            return factory.Query(query);
        }
    }
}
