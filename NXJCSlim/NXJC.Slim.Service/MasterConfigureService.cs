using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class MasterConfigureService
    {
        private string connString;
        public MasterConfigureService()
        {
            connString = ConnectionStringFactory.GetNXJCConnectionString();
        }

        public DataTable GetEquipment(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetByProductLineId(productLineId);
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT VariableName, EquipmentName FROM  ContrastTable";
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetMaser(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetByProductLineId(productLineId);
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT VariableName, EquipmentName FROM  ContrastTable WHERE Ismaster = 1";
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetAlarmConfigure(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetByProductLineId(productLineId);
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT VariableName, EquipmentName, Ismaster, Belong, IsAlarm, StopPosition, AlarmPosition, AlarmMessage FROM  ContrastTable WHERE Ismaster = 1 OR Belong is not null";
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }
    }
}
