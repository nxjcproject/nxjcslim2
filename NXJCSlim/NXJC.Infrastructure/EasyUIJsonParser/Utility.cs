using EasyUIJsonParser.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EasyUIJsonParser
{
    public static class Utility
    {
        /// <summary>
        /// 获取指定名称的数值
        /// </summary>
        /// <param name="json"></param>
        /// <param name="field"></param>
        /// <returns></returns>
        public static string JsonPick(this string json, string field)
        {
            return JsonHelper.ValuePicker(field, json);
        }
        /// <summary>
        /// 获得指定名称Json数组
        /// </summary>
        /// <param name="json"></param>
        /// <param name="field"></param>
        /// <returns></returns>
        public static string[] JsonPickArray(this string json, string field)
        {
            return JsonHelper.ArrayPicker(field, json);
        }
    }
}
