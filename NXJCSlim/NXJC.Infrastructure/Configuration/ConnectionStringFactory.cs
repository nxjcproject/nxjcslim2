using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Infrastructure.Configuration
{
    public static class ConnectionStringFactory
    {
        /// <summary>
        /// DatabaseModel仓库
        /// </summary>
        private static readonly IList<DatabaseModel> databaseBox = new List<DatabaseModel>();
        /// <summary>
        /// 数据库访问工厂
        /// </summary>
        private static ISqlServerDataFactory dataFactory;
        /// <summary>
        /// 集团管理数据库连接字符串
        /// </summary>
        public static string NXJCConnectionString { get; private set; }

        static ConnectionStringFactory()
        {
            NXJCConnectionString = ApplicationSettingsFactory.GetApplicationSettings().NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(NXJCConnectionString);
            Initialize();
        }
        /// <summary>
        /// 初始化DatabaseModel仓库
        /// </summary>
        private static void Initialize()
        {
            databaseBox.Clear();
            Query query = new Query("DatabaseContrast");
            DataTable table = dataFactory.Query(query);

            foreach (DataRow row in table.Rows)
            {
                DatabaseModel model = new DatabaseModel
                {
                    DatabaseContrastID = int.Parse(row["DatabaseContrastID"].ToString()),
                    CompanyID = int.Parse(row["CompanyID"].ToString()),
                    DCSSystemID = int.Parse(row["DCSSystemID"].ToString()),
                    FactoryID = int.Parse(row["FactoryID"].ToString()),
                    ProductLineID = int.Parse(row["ProductLineID"].ToString()),
                    Type = int.Parse(row["Type"].ToString()),

                    DatabaseName = row["DatabaseName"].ToString().Trim(),
                    IPAddress = row["IPAddress"].ToString().Trim(),
                    UserID = row["UserID"].ToString().Trim(),
                    Password = row["Password"].ToString().Trim()
                };

                databaseBox.Add(model);
            }
        }
        /// <summary>
        /// 通过生产线ID获得连接字符串
        /// </summary>
        /// <param name="productLineID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string GetConnectionStringByProductLineID(int productLineID, DatabaseType type)
        {
            DatabaseModel model;

            if (databaseBox.Where(d => d.ProductLineID == productLineID && d.Type == (int)type).Count() > 1)
                throw new ApplicationException("指定数据库不唯一");

            model = databaseBox.FirstOrDefault(d => d.ProductLineID == productLineID && d.Type == (int)type);
            if (model != null)
            {
                return TranslateToConnectionString(model);
            }
            else
            {
                throw new ApplicationException("未找到指定数据库");
            }
        }
        /// <summary>
        /// 通过生产线ID获得数据库名称
        /// </summary>
        /// <param name="productLineID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string GetCatalogNameByProductLineID(int productLineID, DatabaseType type)
        {
            DatabaseModel model;

            if (databaseBox.Where(d => d.ProductLineID == productLineID && d.Type == (int)type).Count() > 1)
                throw new ApplicationException("指定数据库不唯一");

            model = databaseBox.FirstOrDefault(d => d.ProductLineID == productLineID && d.Type == (int)type);
            if (model != null)
            {
                return model.DatabaseName;
            }
            else
            {
                throw new ApplicationException("未找到指定数据库");
            }
        }
        /// <summary>
        /// 通过DCS系统ID获得连接字符串
        /// </summary>
        /// <param name="dcsSystemID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string GetConnectionStringByDSCSystemID(int dcsSystemID, DatabaseType type)
        {
            DatabaseModel model;

            if (databaseBox.Where(d => d.DCSSystemID == dcsSystemID && d.Type == (int)type).Count() > 1)
                throw new ApplicationException("指定数据库不唯一");

            model = databaseBox.FirstOrDefault(d => d.DCSSystemID == dcsSystemID && d.Type == (int)type);
            if (model != null)
            {
                return TranslateToConnectionString(model);
            }
            else
            {
                throw new ApplicationException("未找到指定数据库");
            }
        }
        /// <summary>
        /// 根据生产线ID获得连接字符串
        /// </summary>
        /// <param name="factoryID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string GetConnectionStringByFactoryID(int factoryID, DatabaseType type)
        {
            IEnumerable<DatabaseModel> models = databaseBox.Where(d => d.FactoryID == factoryID && d.Type == (int)type);

            if (models.Count() == 0)
            {
                throw new ApplicationException("未找到指定数据库");
            }

            if (models.Count() > 1)
            {
                throw new ApplicationException("数据库不唯一");
            }

            return TranslateToConnectionString(models.First());
        }
        /// <summary>
        /// 根据生产线ID获得连接字符串集合
        /// </summary>
        /// <param name="factoryID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string[] GetConnectionStringArrayByFactoryID(int factoryID, DatabaseType type)
        {
            IList<string> results = new List<string>();
            List<DatabaseModel> models = databaseBox.Where(d => d.FactoryID == factoryID && d.Type == (int)type).ToList();
            if (models.Count() == 0)
            {
                throw new ApplicationException("未找到指定数据库");
            }

            foreach (var item in models)
            {
                results.Add(TranslateToConnectionString(item));
            }
            return results.ToArray();
        }
        /// <summary>
        /// 根据分厂ID获得连接字符串集合
        /// </summary>
        /// <param name="companyID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public static string[] GetConnectionStringByCompanyID(int companyID, DatabaseType type)
        {
            IList<string> results = new List<string>();
            List<DatabaseModel> models = databaseBox.Where(d => d.CompanyID == companyID && d.Type == (int)type).ToList();
            if (models.Count() == 0)
            {
                throw new ApplicationException("未找到指定数据库");
            }

            foreach (var item in models)
            {
                results.Add(TranslateToConnectionString(item));
            }
            return results.ToArray();
        }
        /// <summary>
        /// 将DatabaseModel翻译成连接字符串
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private static string TranslateToConnectionString(DatabaseModel model)
        {
            string connModel = ApplicationSettingsFactory.GetApplicationSettings().ConnectionStringModel;

            return String.Format(connModel, model.IPAddress, model.DatabaseName, model.UserID, model.Password);
        }
    }
}
