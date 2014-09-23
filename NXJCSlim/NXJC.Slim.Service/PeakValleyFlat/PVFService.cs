using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SqlServerDataAdapter;
using NXJC.Slim.Service.Infrastructure;
using System.Data;
using System.Transactions;

namespace NXJC.Slim.Service.PeakValleyFlat
{
    public class PVFService
    {
        private ISqlServerDataFactory dataFactory;

        public PVFService()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();
            dataFactory = new SqlServerDataFactory(connString);
        }

        public IList<PVFItem> GetPVFByCompanyID(int companyId)
        {
            IList<PVFItem> result = new List<PVFItem>();

            Query query = new Query("PeakValleyFlat");
            query.AddCriterion("CompanyID", companyId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            DataTable dt = dataFactory.Query(query);

            foreach (DataRow row in dt.Rows)
            {
                PVFItem item = new PVFItem();
                item.ID = int.Parse(row["ID"].ToString());
                item.GroupID = int.Parse(row["GroupID"].ToString());
                item.CompanyID = int.Parse(row["CompanyID"].ToString());
                item.EndTime = row["EndTime"].ToString().Trim();
                item.StartTime = row["StartTime"].ToString().Trim();
                item.Flag = (bool)row["Flag"];
                item.Type = int.Parse(row["Type"].ToString());
                result.Add(item);
            }

            return result;
        }

        public void SavePVFValues(IList<PVFItem> inserted, IList<PVFItem> updated, IList<PVFItem> deleted)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                foreach (var item in inserted)
                {
                    Insert<PVFItem> insert = new Insert<PVFItem>("PeakValleyFlat", item);
                    insert.AddExcludeField("ID");
                    dataFactory.Save<PVFItem>(insert);
                }
                foreach (var item1 in updated)
                {
                    Update<PVFItem> update = new Update<PVFItem>("PeakValleyFlat", item1);
                    update.AddCriterion("ID", "ID", item1.ID, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
                    update.AddExcludeField("ID");
                    dataFactory.Save<PVFItem>(update);
                }
                foreach (var item2 in deleted)
                {
                    Delete delete = new Delete("PeakValleyFlat");
                    delete.AddCriterions("ID", "ID",item2.ID, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
                    dataFactory.Remove(delete);
                }
                scope.Complete();
            }
        }
    }
}
