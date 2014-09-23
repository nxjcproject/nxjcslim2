using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public static class Utility
    {
        public static string JsonPick(this string json, string field)
        {
            return JsonHelper.ValuePicker(field, json);
        }

        public static string[] JsonPickArray(this string json, string field)
        {
            return JsonHelper.ArrayPicker(field, json);
        }
    }
}
