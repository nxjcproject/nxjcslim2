using SqlServerDataAdapter;
using SqlServerDataAdapter.Infrastruction;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service.Infrastructure
{
    public static class ConnectionStringFactory
    {
        /// <summary>
        /// 以生产线ID为键的过程数据库名字典
        /// </summary>
        public static readonly Dictionary<int, string> ProcessCatalogDictionary = new Dictionary<int, string>();
        /// <summary>
        /// 以分厂ID为键的电能与产量数据库名字典
        /// </summary>
        public static readonly Dictionary<int, string> MeterCatalogDaictionary = new Dictionary<int, string>();

        static ConnectionStringFactory()
        {
            InitializeProcessCatalogDictionary();
            InitializeMeterCatalogDictionary();
        }


        /// <summary>
        /// 重置数据库名字典
        /// </summary>
        public static void ResetProcessCatalogDictionary()
        {
            InitializeProcessCatalogDictionary();
            InitializeMeterCatalogDictionary();
        }

        /// <summary>
        /// 按生产线ID获取数据库连接字符串
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static string GetByProductLineId(int productLineId)
        {
            string catalog = GetCatalogByProductLineId(productLineId);
            string connectionString =
                string.Format(ConfigurationManager.ConnectionStrings["ProcessData"].ConnectionString, catalog);
            return connectionString;
        }

        /// <summary>
        /// 按分厂ID获取数据库连接字符串
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static string GetByFactoryId(int factoryID)
        {
            string catalog = GetCatalogByFactoryID(factoryID);
            string connectionString =
                string.Format(ConfigurationManager.ConnectionStrings["ProcessData"].ConnectionString, catalog);
            return connectionString;
        }

        /// <summary>
        /// 获取管理数据库连接字符串
        /// </summary>
        /// <returns></returns>
        public static string GetNXJCConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;
        }

        /// <summary>
        /// 按生产线ID获取数据库名（优先从缓存中查找）
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        private static string GetCatalogByProductLineId(int productLineId)
        {
            if (ProcessCatalogDictionary.ContainsKey(productLineId))
                return ProcessCatalogDictionary[productLineId];

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("ProductLineId", productLineId, CriteriaOperator.Equal);
            DataTable dt = factory.Query(query);

            if (dt.Rows.Count == 0)
                throw new ApplicationException("没有此生产线");

            ProcessCatalogDictionary.Add(productLineId, dt.Rows[0]["DataBaseName"].ToString().Trim());
            return ProcessCatalogDictionary[productLineId];             
        }
        /// <summary>
        /// 按分厂ID获取数据库名（优先从缓存中查找）
        /// </summary>
        /// <param name="factoryID"></param>
        /// <returns></returns>
        private static string GetCatalogByFactoryID(int factoryID)
        {
            if (MeterCatalogDaictionary.ContainsKey(factoryID))
                return MeterCatalogDaictionary[factoryID];

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;
            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("FactoryID", factoryID, CriteriaOperator.Equal);
            DataTable dt = factory.Query(query);

            if (dt.Rows.Count == 0)
                throw new ApplicationException("没有此分公司");

            MeterCatalogDaictionary.Add(factoryID, dt.Rows[0]["DataBaseName"].ToString().Trim());
            return MeterCatalogDaictionary[factoryID];
        }

        /// <summary>
        /// 初始化过程数据库名字典
        /// </summary>
        private static void InitializeProcessCatalogDictionary()
        {
            ProcessCatalogDictionary.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("ProductLineID", 0, CriteriaOperator.MoreThanOrEqual);
            DataTable dt = factory.Query(query);

            foreach(DataRow row in dt.Rows)
                ProcessCatalogDictionary.Add(int.Parse(row["ProductLineID"].ToString()), row["DataBaseName"].ToString().Trim());
        }
        /// <summary>
        /// 初始化电能与产量数据库字典
        /// </summary>
        private static void InitializeMeterCatalogDictionary()
        {
            MeterCatalogDaictionary.Clear();

            string connectionString = ConfigurationManager.ConnectionStrings["ManagementData"].ConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);

            Query query = new Query("DataBaseContrast");
            query.AddCriterion("FactoryID", 0, CriteriaOperator.MoreThanOrEqual);
            DataTable dt = factory.Query(query);

            foreach (DataRow row in dt.Rows)
                ProcessCatalogDictionary.Add(int.Parse(row["FactoryID"].ToString()), row["DataBaseName"].ToString().Trim());
        }
    }
}
