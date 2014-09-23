using NXJC.Slim.Service.Infrastructure;
using NXJC.Slim.Service.Infrastructure.Configuration;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class ProductLineService
    {
        public static DataTable GetProductLines()
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("ProductLine");

            return factory.Query(query);
        }

        /// <summary>
        /// 按生产线ID获取标签
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetLabelsByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetByProductLineId(productLineId);

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("ContrastTable");

            DataTable dt = factory.Query(query);
            foreach (DataRow row in dt.Rows)
            {
                row["ViewName"] = ViewsDictionary.Current.GetChineseSafely(row["ViewName"].ToString().Trim());
            }

            return dt;
        }

    }
}
