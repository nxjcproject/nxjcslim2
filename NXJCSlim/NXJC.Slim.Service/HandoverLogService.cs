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
    public class HandoverLogService
    {
        public static DataTable GetHandoverLog()
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  WorkingTeamShiftLog.*, 
                                                StaffInfo.Name AS ChargeManName, ProductLine.Name AS ProductLineName, 
                                                WorkingTeam.Name AS WorkingTeamName
                                        FROM    WorkingTeam INNER JOIN
                                                StaffInfo INNER JOIN
                                                WorkingTeamShiftLog ON StaffInfo.ID = WorkingTeamShiftLog.ChargeManID INNER JOIN
                                                ProductLine ON WorkingTeamShiftLog.ProductLineID = ProductLine.ID ON 
                                                WorkingTeam.ID = WorkingTeamShiftLog.WorkingTeamID";

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        public static DataTable GetHandoverLogByHandoverLogId(int handoverLogId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  WorkingTeamShiftLog.*, 
                                                StaffInfo.Name AS ChargeManName, ProductLine.Name AS ProductLineName, 
                                                WorkingTeam.Name AS WorkingTeamName
                                        FROM    WorkingTeam INNER JOIN
                                                StaffInfo INNER JOIN
                                                WorkingTeamShiftLog ON StaffInfo.ID = WorkingTeamShiftLog.ChargeManID INNER JOIN
                                                ProductLine ON WorkingTeamShiftLog.ProductLineID = ProductLine.ID ON 
                                                WorkingTeam.ID = WorkingTeamShiftLog.WorkingTeamID
                                        WHERE   (WorkingTeamShiftLog.ID = @workingTeamShiftLogID)";

                command.Parameters.Add(new SqlParameter("workingTeamShiftLogID", handoverLogId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        public static DataTable GetWorkingSectionAssignmentByHandoverLogId(int handoverLogId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT  WorkingTeamShiftLogOperators.*, StaffInfo.Name AS StaffName, 
                                                WorkingSection.Name AS WorkingSectionName
                                        FROM    StaffInfo INNER JOIN
                                                WorkingTeamShiftLogOperators ON StaffInfo.ID = WorkingTeamShiftLogOperators.StaffID INNER JOIN
                                                WorkingSection ON WorkingTeamShiftLogOperators.WorkingSectionID = WorkingSection.ID
                                        WHERE   (WorkingTeamShiftLogOperators.WorkingTeamShiftLogID = @workingTeamShiftLogID)";

                command.Parameters.Add(new SqlParameter("workingTeamShiftLogID", handoverLogId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }
    }
}
