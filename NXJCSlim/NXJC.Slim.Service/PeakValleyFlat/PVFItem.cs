using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.PeakValleyFlat
{
    public class PVFItem
    {
        public int ID { get; set; }
        public int GroupID { get; set; }
        public int CompanyID { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public int Type { get; set; }
        public bool Flag { get; set; }
    }
}
