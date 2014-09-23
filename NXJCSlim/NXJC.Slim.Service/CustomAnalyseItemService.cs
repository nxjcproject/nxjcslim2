using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class CustomAnalyseItemService
    {
         private string connString;

         public CustomAnalyseItemService()
        {
            connString = ConnectionStringFactory.GetNXJCConnectionString();
        }

        public DataTable GetProcessDatas(ArrayList labelName)
        {
            string selectString = "";
            SqlConnection conn = new SqlConnection(connString);
            SqlCommand cmd = conn.CreateCommand();
            if (labelName.Count == 1)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + " FROM chart_template";
            }
            if (labelName.Count == 2)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] + " FROM chart_template";
            }
            if (labelName.Count == 3)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] + ", DATA_VALUE_3 AS " + labelName[2] + " FROM chart_template";
            }
            if (labelName.Count == 4)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] +
                    ", DATA_VALUE_3 AS " + labelName[2] + ", DATA_VALUE_4 AS " + labelName[3] + " FROM chart_template";
            }
            if (labelName.Count == 5)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] +
                    ", DATA_VALUE_3 AS " + labelName[2] + ", DATA_VALUE_4 AS " + labelName[3] + ", DATA_VALUE_5 AS " + labelName[4] + " FROM chart_template";
            }
            if (labelName.Count == 6)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] +
                    ", DATA_VALUE_3 AS " + labelName[2] + ", DATA_VALUE_4 AS " + labelName[3] +
                    ", DATA_VALUE_5 AS " + labelName[4] + ", DATA_VALUE_6 AS " + labelName[5] + " FROM chart_template";
            }
            if (labelName.Count == 7)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] +
                    ", DATA_VALUE_3 AS " + labelName[2] + ", DATA_VALUE_4 AS " + labelName[3] +
                    ", DATA_VALUE_5 AS " + labelName[4] + ", DATA_VALUE_6 AS " + labelName[5] + ", DATA_VALUE_7 AS " + labelName[6] + " FROM chart_template";
            }
            if (labelName.Count == 8)
            {
                selectString = @"SELECT TOP 30 DATA_VALUE_1 AS " + labelName[0] + ", DATA_VALUE_2 AS " + labelName[1] +
                    ", DATA_VALUE_3 AS " + labelName[2] + ", DATA_VALUE_4 AS " + labelName[3] +
                    ", DATA_VALUE_5 AS " + labelName[4] + ", DATA_VALUE_6 AS " + labelName[5] + ", DATA_VALUE_7 AS " + labelName[6] + ", DATA_VALUE_8 AS " + labelName[7] + " FROM chart_template";
            }

            cmd.CommandText = selectString;

            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);

            return dt;
        }

        public DataTable GetDIYAnalyseModel()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM DIYAnalyseModel";

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetModelDatasByDIYAnalyseModelID(int id)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM DIYModels WHERE DIYAnalyseModelID=" + id;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }
    }
}
