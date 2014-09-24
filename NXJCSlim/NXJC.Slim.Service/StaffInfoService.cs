using NXJC.Infrastructure.Configuration;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class StaffInfoService
    {
        private ISqlServerDataFactory dataFactory;

        public StaffInfoService()
        {
            string connString = ConnectionStringFactory.NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(connString);
        }

        public DataTable GetStaffInfo()
        {
            Query query = new Query("StaffInfo");
            DataTable dt = dataFactory.Query(query);
            return dt;
        }
    }
}
