using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace NXJC.Slim.Service.Infrastructure
{
    public class TreeGridJsonParser
    {
        /// <summary>
        /// 按groupBy列生成带有一级children的json
        /// </summary>
        /// <param name="table"></param>
        /// <param name="groupBy"></param>
        /// <param name="columnsToParse"></param>
        /// <returns></returns>
        public static string DataTableToJson(DataTable table, string groupBy, params string[] columnsToParse)
        {
            if (table == null || table.Rows.Count == 0)
                return "[]";

            StringBuilder sb = new StringBuilder();
            sb.Append("[");

            DataTable rootTable = table.DefaultView.ToTable(true, groupBy);

            foreach (DataRow rootRow in rootTable.Rows)
            {
                sb.Append("{");
                sb.Append("\"guid\":\"").Append(Guid.NewGuid()).Append("\",");
                sb.Append("\"").Append(columnsToParse[0]).Append("\":").Append("\"").Append(rootRow[0].ToString().Trim()).Append("\",");
                sb.Append("\"state\":\"closed\",");
                sb.Append("\"children\":[");
                
                string filter = string.Format("{0}='{1}'", groupBy, rootRow[0].ToString());
                DataRow[] children = table.Select(filter);

                if (children.Length > 0)
                {
                    foreach (DataRow child in children)
                    {
                        sb.Append("{");
                        sb.Append("\"guid\":\"").Append(Guid.NewGuid()).Append("\",");
                        foreach (string column in columnsToParse)
                        {
                            sb.Append("\"").Append(column).Append("\":").Append("\"").Append(child[column].ToString().Trim()).Append("\",");
                        }
                        sb.Remove(sb.Length - 1, 1);

                        sb.Append("},");
                    }
                    sb.Remove(sb.Length - 1, 1);
                }

                sb.Append("]");
                sb.Append("},");
            }
            sb.Remove(sb.Length - 1, 1).Append("]");

            return sb.ToString();
        }

        /// <summary>
        /// 按parentIdColumn列生成带有_parentId的json
        /// </summary>
        /// <param name="table"></param>
        /// <param name="idColumn"></param>
        /// <param name="parentIdColumn"></param>
        /// <param name="columnsToParse"></param>
        /// <returns></returns>
        public static string DataTableToJson(DataTable table, string idColumn, string parentIdColumn, params string[] columnsToParse)
        {
            if (table == null || table.Rows.Count == 0)
                return "[]";

            StringBuilder sb = new StringBuilder();
            sb.Append("{\"total\":").Append(table.Rows.Count).Append(",");
            sb.Append("\"rows\":[");

            foreach (DataRow row in table.Rows)
            {
                sb.Append("{\"").Append(idColumn).Append("\":\"");
                sb.Append(row[idColumn].ToString().Trim());
                sb.Append("\",");

                if (row[parentIdColumn].ToString().Trim().Length > 0)
                {
                    sb.Append("\"_parentId\":\"");
                    sb.Append(row[parentIdColumn].ToString().Trim());
                    sb.Append("\",");
                }

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

        /// <summary>
        /// 按含有嵌套children的json生成datatable
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public static DataTable JsonToDataTable(string json)
        {
            DataTable dt = new DataTable();

            // 行元素集合
            IList<string> components = new List<string>();
            // 列元素集合
            IList<string> columns = new List<string>();

            // 行元素匹配
            var rgComponent = new Regex(@"{[^{}]+}");
            // 列元素匹配
            var rgColumn = new Regex(@"""([^""]+)"":");

            // 匹配行元素
            MatchCollection mc;
            do
            {
                mc = rgComponent.Matches(json);
                for (int i = 0; i < mc.Count; i++)
                {
                    components.Add(mc[i].Value);
                }
                json = rgComponent.Replace(json, "");

            } while (mc.Count > 0);

            // 匹配列元素
            foreach (string component in components)
            {
                mc = rgColumn.Matches(component);
                for (int i = 0; i < mc.Count; i++)
                {
                    if (columns.Contains(mc[i].Groups[1].Value) == false)
                        columns.Add(mc[i].Groups[1].Value);
                }
            }

            // 去除treegrid生成列
            if (columns.Contains("children"))
                columns.Remove("children");
            if (columns.Contains("_parentId"))
                columns.Remove("_parentId");
            if (columns.Contains("state"))
                columns.Remove("state");

            // 构建datatable
            foreach (string column in columns)
            {
                DataColumn col = new DataColumn(column);
                dt.Columns.Add(col);
            }

            foreach (string component in components)
            {
                DataRow row = dt.NewRow();

                foreach (string column in columns)
                {
                    var rgValue = new Regex(@"""" + column + @""":""([^""""]+)""");
                    mc = rgValue.Matches(component);
                    if (mc.Count > 0)
                        row[column] = mc[0].Groups[1].Value;
                }

                dt.Rows.Add(row);
            }


            return dt;
        }
    }
}
