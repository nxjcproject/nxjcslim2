using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure.Configuration
{
    public class ViewsDictionary
    {
        static readonly ViewsDictionary instance = new ViewsDictionary();

        static ViewsDictionary()
        {
        }

        public static ViewsDictionary Current
        {
            get { return instance; }
        }

        private IDictionary<string, string> dictionary;

        private ViewsDictionary()
        {
            dictionary = new Dictionary<string, string>();
            InitializeDictionary();
        }

        public string this[string key]
        {
            get { return dictionary[key]; }
        }

        public string GetChineseSafely(string english)
        {
            if (dictionary.ContainsKey(english))
                return dictionary[english];

            return english;
        }

        private void InitializeDictionary()
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("ViewsDictionary");
            DataTable dt = factory.Query(query);

            foreach (DataRow row in dt.Rows)
                dictionary.Add(row["English"].ToString(), row["Chinese"].ToString());
        }
    }
}