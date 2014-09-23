using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SqlServerDataAdapter;
using NXJC.Slim.Service.Infrastructure;
using System.Data;
using System.Runtime.Serialization;

namespace NXJC.Slim.Service
{
    public class GroupService
    {
        private ISqlServerDataFactory dataFactory;

        public GroupService()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();
            dataFactory = new SqlServerDataFactory(connString);
        }

        public IEnumerable<GroupTreeNode> GetCompanyTreeNode()
        {
            IList<GroupTreeNode> result = new List<GroupTreeNode>();

            Query query = new Query("Company");
            DataTable dt = dataFactory.Query(query);
            foreach (DataRow row in dt.Rows)
            {
                GroupTreeNode item = new GroupTreeNode();
                if (row["ID"].ToString().Trim() != "")
                {
                    item.CompanyID = int.Parse(row["ID"].ToString().Trim());
                }
                item.Name = row["Name"].ToString().Trim();
                item.Address = row["Address"].ToString().Trim();
                item.CommissioningDate = row["CommissioningDate"].ToString();
                item.Products = row["Products"].ToString().Trim();
                result.Add(item);
            }

            return result;
        }

        public IEnumerable<GroupTreeNode> GetFactoryTreeNode(GroupTreeNode companyTreeNode)
        {
            IList<GroupTreeNode> result = new List<GroupTreeNode>();

            Query query = new Query("Factory");
            query.AddCriterion("CompanyID", companyTreeNode.CompanyID, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            DataTable dt = dataFactory.Query(query);
            foreach (DataRow row in dt.Rows)
            {
                GroupTreeNode item = new GroupTreeNode();
                item.CompanyID = int.Parse(row["CompanyID"].ToString().Trim());
                item.FactoryID = int.Parse(row["ID"].ToString().Trim());
                item.Name = row["Name"].ToString().Trim();
                item.Address = row["Address"].ToString().Trim();
                item.CommissioningDate = row["CommissioningDate"].ToString();
                item.Products = row["Products"].ToString().Trim();
                result.Add(item);
            }

            return result;
        }

        public IEnumerable<GroupTreeNode> GetProductLineTreeNode(GroupTreeNode factoryTreeNode)
        {
            IList<GroupTreeNode> result = new List<GroupTreeNode>();

            Query query = new Query("ProductLine");
            query.AddCriterion("CompanyID", "a",factoryTreeNode.CompanyID, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            query.AddCriterion("FactoryID", "b",factoryTreeNode.FactoryID, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            DataTable dt = dataFactory.Query(query);
            foreach (DataRow row in dt.Rows)
            {
                GroupTreeNode item = new GroupTreeNode();
                item.ProductLineID = int.Parse(row["ID"].ToString().Trim());
                item.CompanyID = int.Parse(row["CompanyID"].ToString().Trim());
                item.FactoryID = int.Parse(row["FactoryID"].ToString().Trim());
                item.Name = row["Name"].ToString().Trim();
                item.Address = row["Address"].ToString().Trim();
                item.CommissioningDate = row["CommissioningDate"].ToString();
                item.Products = row["Products"].ToString().Trim();
                item.children = null;
                result.Add(item);
            }

            return result;
        }

        public IEnumerable<GroupTreeNode> GetTreeGridDatas()
        {
            IEnumerable<GroupTreeNode> CompanyTreeNode = GetCompanyTreeNode();

            foreach (var complanyItem in CompanyTreeNode)
            {
                IEnumerable<GroupTreeNode> FactoryTreeNode = GetFactoryTreeNode(complanyItem);

                foreach (var factoryItem in FactoryTreeNode)
                {
                    IEnumerable<GroupTreeNode> ProductLineTreeNode = GetProductLineTreeNode(factoryItem);
                    factoryItem.children = ProductLineTreeNode;
                }
                complanyItem.children = FactoryTreeNode;
            }

            return CompanyTreeNode;
        }



    }

    [DataContract]
    public class GroupTreeNode
    {
        public GroupTreeNode()
        {
            children = new List<GroupTreeNode>();
            guid = Guid.NewGuid();
        }
        [DataMember]
        public Guid guid { get; set; }
        [DataMember]
        public int CompanyID { get; set; }
        [DataMember]
        public int FactoryID { get; set; }
        [DataMember]
        public int ProductLineID { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public string Address { get; set; }
        [DataMember]
        public string CommissioningDate { get; set; }
        [DataMember]
        public string Products { get; set; }
        [DataMember]
        public IEnumerable<GroupTreeNode> children { get; set; }
    }
}
