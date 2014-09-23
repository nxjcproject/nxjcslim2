using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public class DataGridJsonParser
    {
        public static string DataTableToJson(DataTable table, params string[] columnsToParse)
        {
            if (table == null || table.Rows.Count == 0)
                return "{\"total\":0,\"rows\":[]}";

            StringBuilder sb = new StringBuilder();
            sb.Append("{\"total\":").Append(table.Rows.Count).Append(",");
            sb.Append("\"rows\":[");

            foreach (DataRow row in table.Rows)
            {
                sb.Append("{");

                foreach (string column in columnsToParse)
                {
                    sb.Append("\"").Append(column).Append("\":").Append("\"").Append(row[column].ToString().Trim()).Append("\",");
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("},");
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]}");

            return sb.ToString();
        }
    }
}
