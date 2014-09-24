using EasyUIJsonParser.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EasyUIJsonParser
{
    public class ChartJsonParser
    {
        public static string DataTableToJson(DataTable table, string myUnitX, string myUnitY, string myMaxY)
        {
            StringBuilder Json = new StringBuilder();

            if (table.Rows.Count == 0)
            {
                return "[]";
            }

            Json.Append("{\"total\":" + table.Columns.Count + ",");
            if (table.Columns.Count > 0)
            {
                Json.Append("\"rows\":");
                Json.Append(JsonHelper.TransformTableToJson(table));
                Json.Append(",\"columns\":[");
            }

            Json.Append("{");
            Json.Append("\"title\":\"名称\"");
            Json.Append(", \"field\":\"RowId\"");
            Json.Append("}");

            for (int i = 0; i < table.Rows.Count; i++)
            {
                Json.Append(",{");
                Json.Append("\"title\":\"" + (i + 1).ToString() + "\"");
                Json.Append(", \"field\":\"Col" + (i + 1).ToString() + "\"");
                Json.Append("}");
            }
            Json.Append("],\"Units\":{");
            Json.Append("\"UnitX\":\"" + myUnitX + "\"");
            Json.Append(",\"UnitY\":\"" + myUnitY + "\"");
            Json.Append(",\"MaxY\":\"" + myMaxY + "\"");
            Json.Append("}}");

            return Json.ToString();
        }
    }
}
