using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class CementTypeConvertCoefficientService
    {
        private ISqlServerDataFactory dataFactory;

        public CementTypeConvertCoefficientService()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();
            dataFactory = new SqlServerDataFactory(connString);
        }

        public DataTable GetDatas()
        {
            Query query = new Query("CementTypesAndConvertCoefficient");
            DataTable dt = dataFactory.Query(query);

            return dt;
        }
    }
}
