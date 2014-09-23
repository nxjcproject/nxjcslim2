using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Text.RegularExpressions;

namespace NXJC.Slim.Service.Infrastructure
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

        public static object JsonToObject(string jsonString, Object obj)
        {
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(obj.GetType());
            MemoryStream stream = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
            return serializer.ReadObject(stream);
        }

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

            if(mc.Count == 0)
                return new string[] { };

            for (int i = 0; i < mc.Count; i++)
            {
                results.Add(mc[i].Value);
            }

            return results.ToArray();
        }
    }
}
