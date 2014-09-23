using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public class TreeJsonParser
    {
        public static string DataTableToJson(DataTable table, string idColumn, string textColumn, string relativeColumn, object parentId = null)
        {
            StringBuilder result = new StringBuilder();
            StringBuilder temp = new StringBuilder();

            DataTableToJson(result, temp, table, idColumn, textColumn, relativeColumn, parentId);

            return result.ToString();
        }

        private static void DataTableToJson(StringBuilder result, StringBuilder temp, DataTable table, string idColumn, string textColumn, string relativeColumn, object parentId)
        {
            result.Append(temp.ToString());
            temp.Clear();
            if (table.Rows.Count > 0)
            {
                temp.Append("[");
                string filer = string.Format("{0}='{1}'", relativeColumn, parentId);
                DataRow[] rows = table.Select(filer);
                if (rows.Length > 0)
                {
                    foreach (DataRow row in rows)
                    {
                        temp.Append("{\"id\":\"" + row[idColumn] + "\",\"text\":\"" + row[textColumn] + "\",\"state\":\"open\"");
                        if (table.Select(string.Format("{0}='{1}'", relativeColumn, row[idColumn])).Length > 0)
                        {
                            temp.Append(",\"children\":");
                            DataTableToJson(result, temp, table, idColumn, textColumn, relativeColumn, row[idColumn]);
                            result.Append(temp.ToString());
                            temp.Clear();
                        }
                        result.Append(temp.ToString());
                        temp.Clear();
                        temp.Append("},");
                    }
                    temp = temp.Remove(temp.Length - 1, 1);
                }
                temp.Append("]");
                result.Append(temp.ToString());
                temp.Clear();
            }
        }
    }
}
