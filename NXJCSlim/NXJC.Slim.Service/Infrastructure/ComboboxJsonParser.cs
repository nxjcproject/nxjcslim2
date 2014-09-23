using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public class ComboboxJsonParser
    {
        public static string DataTableToJson(DataTable table, params string[] columnsToParse)
        {
            if (table == null || table.Rows.Count == 0)
                return "[]";

            StringBuilder sb = new StringBuilder();
            sb.Append("[");

            for (int i = 0; i < table.Rows.Count; i++)
            {
                sb.Append("{");

                for (int j = 0; j < columnsToParse.Length; j++)
                {
                    if (j < columnsToParse.Length - 1)
                        sb.Append("\"" + columnsToParse[j] + "\":" + "\"" + table.Rows[i][columnsToParse[j]].ToString().Trim() + "\",");
                    else
                        sb.Append("\"" + columnsToParse[j] + "\":" + "\"" + table.Rows[i][columnsToParse[j]].ToString().Trim() + "\"");
                }

                if (i == table.Rows.Count - 1)
                    sb.Append("}");
                else
                    sb.Append("},");
            }

            sb.Append("]");

            return sb.ToString();
        }
    }
}
