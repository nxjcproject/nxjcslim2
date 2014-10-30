using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EasyUIJsonParser
{
    public class TreeJsonParser
    {
        /// <summary>
        /// 按levelCode生成json
        /// </summary>
        /// <param name="table">源表</param>
        /// <param name="levelCodeColumn">层次码</param>
        /// <param name="textColumn">呈现文字</param>
        /// <returns>json</returns>
        public static string DataTableToJson(DataTable table, string levelCodeColumn, string textColumn)
        {
            // 当表为空时，返回空json
            if (table == null || table.Rows.Count == 0)
                return "[]";

            // 结果builder
            StringBuilder result = new StringBuilder();
            result.Append("[");

            #region 使用递归生成节点，此段代码用于获取层次码最大长度，已遗弃，留作参考

            // 添加层次码长度列
            //DataColumn levelLengthColumn = new DataColumn("levelLength", typeof(int));
            //levelLengthColumn.Expression = "len(trim(" + levelCodeColumn + "))";
            //table.Columns.Add(levelLengthColumn);
            
            // 计算层次码长度最大值
            //int maxLengthOfLevelCode = (int)table.Compute("max(levelLength)", "true");

            #endregion

            // 获取层次码前缀
            string prefix = table.Rows[0][levelCodeColumn].ToString().Substring(0, 1);
            // 递归生成节点
            Append(result, table, levelCodeColumn, textColumn, prefix);
            
            result.Append("]");

            return result.ToString();
        }

        private static void Append(StringBuilder result, DataTable table, string levelCodeColumn, string textColumn, string parentLevelCode)
        {
            // 子节点筛选器，规则：以parentLevelCode开头，长度为parentLevelCode长度+2
            string childrenFilter = levelCodeColumn + " like '" + parentLevelCode + "*' and len(" + levelCodeColumn + ") = " + (parentLevelCode.Length + 2);
            // 获取子节点集合
            DataRow[] children = table.Select(childrenFilter);

            if (children.Count() == 0)
                return;

            foreach (DataRow child in children)
            {
                result.Append("{\"id\":\"" + child[levelCodeColumn] + "\",\"text\":\"" + child[textColumn] + "\",\"state\":\"open\",\"children\":[");
                // 递归获取当前节点的子节点
                Append(result, table, levelCodeColumn, textColumn, child[levelCodeColumn].ToString());
                result.Append("]},");
            }
            // 移除json中最后一个元素跟着的多余逗号
            result.Remove(result.Length - 1, 1);
        }

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
