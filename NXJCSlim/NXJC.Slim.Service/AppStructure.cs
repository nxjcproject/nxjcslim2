using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class AppStructure
    {
        public enum LevelType : int
        {
            Group = 0,
            Company = 1,
            Factory = 2,
            DCSSystem = 3,
            ProductLine = 4
        }

        public DataTable GetLevelCode(int id = 0, LevelType levelType = LevelType.Company)
        {
            DataTable dt = new DataTable();

            
            
            return dt;
        }

        private DataTable GetLevelOfCompany(int id)
        {
            string CONNECTION_STRING = "";
            DataTable dt = new DataTable();



            return dt;
        }
    }
}
