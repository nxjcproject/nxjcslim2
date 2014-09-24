using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NXJC.Infrastructure.Configuration
{
    public class DatabaseModel
    {
        public int DatabaseContrastID { get; set; }
        public int CompanyID { get; set; }
        public int FactoryID { get; set; }
        public int DCSSystemID { get; set; }
        public int ProductLineID { get; set; }
        public int Type { get; set; }

        public string DatabaseName { get; set; }
        public string IPAddress { get; set; }
        public string UserID { get; set; }
        public string Password { get; set; }
    }
}
