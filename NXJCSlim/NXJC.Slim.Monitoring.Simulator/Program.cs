using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Monitoring.Simulator
{
    class Program
    {
        private static readonly string CONNECTION_STRING = "Data Source=DEC-WINSVR12;Initial Catalog={0};Integrated Security=True";
        private static readonly string[] DATABASES = new string[] { "Db_01_YFC", "Db_01_ND", "Db_01_LS_WastedHeatPower2" };

        private static readonly IDictionary<string, IList<DataTable>> DatabaseTableDictionary = new Dictionary<string, IList<DataTable>>();
        private static readonly IDictionary<string, SqlConnection> DatabaseConnections = new Dictionary<string, SqlConnection>();

        private static readonly Random random = new Random();

        static void Main(string[] args)
        {
            // 初始化数据库字典
            foreach (var databaseName in DATABASES)
            {
                IList<DataTable> tables = new List<DataTable>();

                string connectionString = string.Format(CONNECTION_STRING, databaseName);

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = connection.CreateCommand();
                    command.CommandText = "SELECT DISTINCT TableName FROM ContrastTable";

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            tables.Add(GetStructure(connectionString, reader[0].ToString().Trim()));
                        }
                    }
                }

                DatabaseTableDictionary.Add(databaseName, tables);
            }

            // 建立化数据库连接字典
            foreach (var databaseName in DATABASES)
            {
                string connectionString = string.Format(CONNECTION_STRING, databaseName);
                DatabaseConnections.Add(databaseName, new SqlConnection(connectionString));
            }

            int indexOfDatabase = 0;
            int.TryParse(Console.ReadLine(), out indexOfDatabase);

            Console.WriteLine("宁夏建材实时监控数据仿真, Ctrl + C 退出");

            DatabaseConnections[DATABASES[indexOfDatabase]].Open();

            while (true)
            {

                SqlCommand cmd = DatabaseConnections[DATABASES[indexOfDatabase]].CreateCommand();

                foreach (var dt in DatabaseTableDictionary[DATABASES[indexOfDatabase]])
                {
                    cmd.CommandText = GetUpdateCommand(dt);
                    cmd.ExecuteNonQuery();
                }

                Console.Write(".");
            }
        }

        private static DataTable GetStructure(string connectionString, string table)
        {
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM [" + table + "]";

                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(ds);
                }
            }

            ds.Tables[0].TableName = table;
            return ds.Tables[0];
        }

        private static string GetUpdateCommand(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("UPDATE ");
            sb.Append(dt.TableName);
            sb.Append(" SET ");

            foreach (DataColumn column in dt.Columns)
            {
                sb.Append("[").Append(column.ColumnName).Append("]");
                sb.Append(" = ");
                sb.Append(GetRandomValue(column));
                sb.Append(", ");
            }

            sb.Remove(sb.Length - 2, 2);

            return sb.ToString();
        }

        private static string GetRandomValue(DataColumn column)
        {
            if (column.DataType == typeof(DateTime))
            {
                return "'" + DateTime.Now.ToString() + "'";
            }
            if (column.DataType == typeof(Single))
            {
                return Convert.ToSingle(random.NextDouble()).ToString("#0.00");
            }
            if (column.DataType == typeof(bool))
            {
                return random.Next(2).ToString();
            }

            return "";
        }
    }
}
