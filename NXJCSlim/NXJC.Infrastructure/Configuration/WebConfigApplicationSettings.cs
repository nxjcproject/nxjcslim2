using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;

namespace NXJC.Infrastructure.Configuration
{
    public class WebConfigApplicationSettings : IApplicationSettings
    {
        public string NXJCConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["ManagementData"].ToString(); }
        }

        public string ConnectionStringModel
        {
            get { return ConfigurationManager.ConnectionStrings["ConnectionStringModel"].ToString(); }
        }

        public string IndustryEnergy_SHConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["IndustryEnergy_SH"].ToString(); }
        }

        public string ProcessDataConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["ProcessData"].ToString(); }
        }
    }
}
