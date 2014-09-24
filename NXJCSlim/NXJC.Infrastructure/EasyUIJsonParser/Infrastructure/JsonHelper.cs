using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace EasyUIJsonParser.Infrastructure
{
    public class JsonHelper
    {
        /// <summary>
        /// 从一个对象信息生产Json串
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static string ObjectToJson(object obj)
        {
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(obj.GetType());
            MemoryStream stream = new MemoryStream();
            serializer.WriteObject(stream, obj);
            byte[] dataBytes = new byte[stream.Length];
            stream.Position = 0;
            stream.Read(dataBytes, 0, (int)stream.Length);
            return Encoding.UTF8.GetString(dataBytes);
        }
        /// <summary>
        /// 将Json转换为对象信息
        /// </summary>
        /// <param name="jsonString"></param>
        /// <param name="obj"></param>
        /// <returns></returns>
        public static object JsonToObject(string jsonString, Object obj)
        {
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(obj.GetType());
            MemoryStream stream = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
            return serializer.ReadObject(stream);
        }
        /// <summary>
        /// 将DataTable的第一行转换为Json
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public static string DataTableFirstRowToJson(DataTable table)
        {
            if (table == null || table.Rows.Count == 0)
                return "{}";

            StringBuilder sb = new StringBuilder();
            sb.Append("{");

            for (int i = 0; i < table.Rows.Count; i++)
            {
                foreach (DataColumn dc in table.Columns)
                {
                    sb.Append("\"" + dc.ColumnName + "\":" + "\"" + table.Rows[i][dc.ColumnName].ToString().Trim() + "\",");
                }

                sb.Remove(sb.Length - 1, 1);
            }

            sb.Append("}");

            return sb.ToString();

        }

        /// <summary>
        /// json 字段值选择器
        /// </summary>
        /// <param name="field"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        /// 
        public static string ValuePicker(string field, string json)
        {
            // \s.*? : 任意空白字符
            var rgSimpleValue = new Regex(@"""" + field + @""":""([^""""]+)""");
            var rgComplexValue = new Regex(@"""" + field + @""":((?x){[^{}]*(((?'k'{)[^{}]*)+((?'-k'})[^{}]*)+)*(?(k)(?!))})");
            var rgArrayValue = new Regex(@"""" + field + @""":((?x)\[[^\[\]]*(((?'k'{)[^\[\]]*)+((?'-k'})[^\[\]]*)+)*(?(k)(?!))\])");

            var mc = rgSimpleValue.Matches(json);

            if (mc.Count == 0)
            {
                mc = rgComplexValue.Matches(json);

                if (mc.Count == 0)
                {
                    mc = rgArrayValue.Matches(json);

                    if (mc.Count == 0)
                        return "";
                }
            }

            return mc[0].Groups[1].Value;
        }

        public static string[] ArrayPicker(string field, string json)
        {
            string arrayJson = ValuePicker(field, json);

            if (arrayJson.StartsWith("[") == false || arrayJson.EndsWith("]") == false)
                return new string[] { };

            IList<string> results = new List<string>();

            var rgElement = new Regex("(?x){[^{}]*(((?'k'{)[^{}]*)+((?'-k'})[^{}]*)+)*(?(k)(?!))}");

            var mc = rgElement.Matches(arrayJson);

            if (mc.Count == 0)
                return new string[] { };

            for (int i = 0; i < mc.Count; i++)
            {
                results.Add(mc[i].Value);
            }

            return results.ToArray();
        }
        /// <summary>
        /// 将JsonData转换为json串
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
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
        /// <summary>
        /// 转置table序列化Json
        /// </summary>
        /// <param name="dataTable"></param>
        /// <returns></returns>
        public static string TransformTableToJson(DataTable dataTable)
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
    }
}
