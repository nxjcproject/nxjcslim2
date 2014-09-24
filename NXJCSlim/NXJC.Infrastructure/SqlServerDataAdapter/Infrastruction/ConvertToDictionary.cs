using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace SqlServerDataAdapter.Infrastruction
{
    /// <summary>
    /// 将存储数据库字段数据的类转换为字典
    /// </summary>
    public class ConvertToDictionary
    {
        public static IDictionary<string, object> ConvertTo<T>(T valueClass)
        {
            IDictionary<string, object> results = new Dictionary<string, object>();
            Type typeValue = valueClass.GetType();
            foreach (PropertyInfo item in typeValue.GetProperties())
            {
                string name = item.Name;
                object value = item.GetValue(valueClass, null);

                results.Add(name, value);
            }

            return results;
        }
    }
}
