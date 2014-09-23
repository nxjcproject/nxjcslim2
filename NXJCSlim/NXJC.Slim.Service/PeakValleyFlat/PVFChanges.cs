using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.PeakValleyFlat
{
    public class PVFChanges
    {
        public List<PVFItem> inserted { get; set; }
        public List<PVFItem> updated { get; set; }
        public List<PVFItem> deleted { get; set; }
    }
}
