using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class WorkingTeamService
    {
        private ISqlServerDataFactory dataFactory;
        string connString;

        public WorkingTeamService()
        {
            connString = ConnectionStringFactory.GetNXJCConnectionString();
            dataFactory = new SqlServerDataFactory(connString);
        }

        public DataTable GetProductLine()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT ID, Name FROM ProductLine";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetStaffInfo()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT ID, Name FROM StaffInfo";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetWorkingTeam()
        {
            Query query = new Query("WorkingTeam");

            DataTable dt = dataFactory.Query(query);

            return dt;
        }
    }
}
