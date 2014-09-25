using NXJC.Infrastructure.Configuration;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class AppStructureService
    {
        private readonly string CONNECTION_STRING;
        private ISqlServerDataFactory dataFactory;

        public AppStructureService()
        {
            CONNECTION_STRING = ConnectionStringFactory.NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(CONNECTION_STRING);
        }

        public enum LevelType : int
        {
            Group = 0,
            Company = 1,
            Factory = 2,
            DCSSystem = 3,
            ProductLine = 4
        }

        public DataTable GetLevelCode(int id = 0, LevelType levelType = LevelType.Company)
        {
            DataTable dt = new DataTable();

            // 层次码
            dt.Columns.Add("LevelCode", typeof(string));
            // ID
            dt.Columns.Add("ID", typeof(int));
            // 类型：公司、分厂、生产线
            dt.Columns.Add("Type", typeof(string));
            // 名称
            dt.Columns.Add("Name", typeof(string));
            // 生产线类型
            dt.Columns.Add("ProductLineType", typeof(int));

            switch (levelType)
            {
                case LevelType.Company:
                    GetLevelOfCompany(dt, "P", id);
                    break;
                case LevelType.Factory:
                    GetLevelOfFactory(dt, "P", id);
                    break;
                case LevelType.ProductLine:
                    GetLevelOfProductLine(dt, "P", id);
                    break;
                default:
                    GetLevelOfCompany(dt, "P", 0);
                    break;
            }

            return dt;
        }

        private void GetLevelOfCompany(DataTable dt, string levelCode, int companyId = 0)
        {
            int codeNumber = 0;

            Query query = new Query("Company");
            if (companyId != 0)
                query.AddCriterion("CompanyID", companyId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            dataFactory.Query(query);

            DataTable companyTable = dataFactory.Query(query);

            foreach (DataRow companyRow in companyTable.Rows)
            {
                codeNumber++;

                DataRow row = dt.NewRow();
                row["LevelCode"] = levelCode + codeNumber.ToString("00");
                row["ID"] = (int)companyRow["CompanyID"];
                row["Type"] = "分公司";
                row["Name"] = companyRow["Name"].ToString();

                dt.Rows.Add(row);

                GetLevelOfFactory(dt, row["LevelCode"].ToString());
            }
        }

        private void GetLevelOfFactory(DataTable dt, string levelCode, int factoryId = 0)
        {
            int codeNumber = 0;

            Query query = new Query("Factory");
            if (factoryId != 0)
                query.AddCriterion("FactoryID", factoryId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            dataFactory.Query(query);

            DataTable factoryTable = dataFactory.Query(query);

            foreach (DataRow factoryRow in factoryTable.Rows)
            {
                codeNumber++;

                DataRow row = dt.NewRow();
                row["LevelCode"] = levelCode + codeNumber.ToString("00");
                row["ID"] = (int)factoryRow["FactoryID"];
                row["Type"] = "分厂";
                row["Name"] = factoryRow["Name"].ToString();

                dt.Rows.Add(row);

                GetLevelOfProductLine(dt, row["LevelCode"].ToString());
            }
        }

        private void GetLevelOfProductLine(DataTable dt, string levelCode, int productLineId = 0)
        {
            int codeNumber = 0;

            Query query = new Query("ProductLine");
            if (productLineId != 0)
                query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            dataFactory.Query(query);

            DataTable productLineTable = dataFactory.Query(query);

            foreach (DataRow productLineRow in productLineTable.Rows)
            {
                codeNumber++;

                DataRow row = dt.NewRow();
                row["LevelCode"] = levelCode + codeNumber.ToString("00");
                row["ID"] = (int)productLineRow["ProductLineID"];
                row["Type"] = "生产线";
                row["Name"] = productLineRow["Name"].ToString();
                row["ProductLineType"] = (int)productLineRow["Type"];

                dt.Rows.Add(row);
            }
        }
    }
}
