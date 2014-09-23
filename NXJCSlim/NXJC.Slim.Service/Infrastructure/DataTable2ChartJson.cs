using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public class DataTable2ChartJson
    {
        public static string ToChartJson(DataTable myDataTable, string myUnitX, string myUnitY, string myMaxY)
        {
            StringBuilder Json = new StringBuilder();

            if (myDataTable.Rows.Count == 0)
            {
                return "[]";
            }

            Json.Append("{\"total\":" + myDataTable.Columns.Count + ",");
            if (myDataTable.Columns.Count > 0)
            {
                Json.Append("\"rows\":");
                Json.Append(TransformTableToJson(myDataTable));
                Json.Append(",\"columns\":[");
            }

            Json.Append("{");
            Json.Append("\"title\":\"名称\"");
            Json.Append(", \"field\":\"RowId\"");
            Json.Append("}");

            for (int i = 0; i < myDataTable.Rows.Count; i++)
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

        /// <summary>
        /// 转置table序列化Json
        /// </summary>
        /// <param name="dataTable"></param>
        /// <returns></returns>
        private static string TransformTableToJson(DataTable dataTable)
        {
            IList<Dictionary<int, JsonData>> resultObject = new List<Dictionary<int, JsonData>>();

            for (int j = 0; j < dataTable.Columns.Count; j++)
            {
                int i = 0;
                Dictionary<int, JsonData> columnsJson = new Dictionary<int, JsonData>();
                JsonData header = new JsonData();
                header.Name = "RowId";
                header.Value = dataTable.Columns[j].ColumnName;
                columnsJson.Add(i, header);
                i++;
                foreach (DataRow row in dataTable.Rows)
                {
                    JsonData dataItem = new JsonData();
                    dataItem.Name = "Col" + i.ToString();
                    dataItem.Value = row[j].ToString().Trim();
                    columnsJson.Add(i, dataItem);
                    i++;
                }

                resultObject.Add(columnsJson);
            }

            string result = DictionarysToJson(resultObject);

            return result;
        }
        /// <summary>
        /// Dictionary<int, JsonData>字典集合序列化为Json串，其中字典键值从零开始
        /// </summary>
        /// <param name="dictionarys"></param>
        /// <returns></returns>
        private static string DictionarysToJson(IEnumerable<Dictionary<int, JsonData>> dictionarys)
        {
            if (dictionarys.Count() == 0)
                return "[]";

            if (dictionarys.Count() == 1)
                return TranslateDictionary(dictionarys.FirstOrDefault());

            StringBuilder result = new StringBuilder();
            result.Append("[");

            foreach (var item in dictionarys)
            {
                string dataItem = TranslateDictionary(item);
                dataItem.Remove(0, 1);
                dataItem.Remove(dataItem.Length - 1, 1);
                result.Append(dataItem).Append(",");
            }
            result.Remove(result.Length - 1, 1);
            result.Append("]");

            return result.ToString();
        }

        private static string TranslateJsonData(JsonData data)
        {
            string result = String.Format("\"{0}\":\"{1}\"", data.Name, data.Value);
            return result;
        }
        /// <summary>
        /// Dictionary<int, JsonData>转换为Json串, 键值从零开始
        /// </summary>
        /// <param name="dictionary"></param>
        /// <returns></returns>
        private static string TranslateDictionary(Dictionary<int, JsonData> dictionary)
        {
            StringBuilder result = new StringBuilder();
            int valueCount = dictionary.Count();

            if (valueCount == 0)
                return "{}";

            result.Append("{");

            for (int i = 0; i < valueCount; i++)
            {
                string item = TranslateJsonData(dictionary[i]);
                result.Append(item).Append(",");
            }
            result.Remove(result.Length - 1, 1);
            result.Append("}");

            return result.ToString();
        }
    }

    public class JsonData
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
}
