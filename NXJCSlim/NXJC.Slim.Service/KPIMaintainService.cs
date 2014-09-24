using NXJC.Infrastructure.Configuration;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class KPIMaintainService
    {
        private ISqlServerDataFactory dataFactory;

        public KPIMaintainService()
        {
            string connString = ConnectionStringFactory.NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(connString);
        }

        public DataTable GetKPI()
        {
            Query query = new Query("KPI");
            DataTable dt = dataFactory.Query(query);

            return dt;
        }
    }
}
