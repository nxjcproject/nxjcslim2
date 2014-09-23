using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class MachineHaltReasonService
    {
        private ISqlServerDataFactory dataFactory;

        public MachineHaltReasonService()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();
            dataFactory = new SqlServerDataFactory(connString);
        }

        public DataTable GetMachineHaltReason()
        {
            Query query = new Query("MachineHaltReason");

            DataTable dt = dataFactory.Query(query);

            return dt;
        }
    }
}
