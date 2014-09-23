using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.EnergyEfficiency
{
    /// <summary>
    /// FormulaService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class FormulaService : System.Web.Services.WebService
    {

        #region Read
        [WebMethod]
        public string ValidateExpression(string expression)
        {
            string[] result =  ExpressionService.ValidateExpression(expression);
            if (result.Length == 0)
                return "success";
            else
                return result[0];
        }

        [WebMethod]
        public string GetFormulaGroupsWithDataGridFormat(int factoryId)
        {
            DataTable formulaGroups = ExpressionService.GetFormulaGroupsByFactoryId(factoryId);

            return DataGridJsonParser.DataTableToJson(formulaGroups, "KeyID", "Name", "CreateDate", "State");
        }

        [WebMethod]
        public string GetFormulaGroupsEffectivedWithDataGridFormat(int factoryId)
        {
            DataTable formulaGroups = ExpressionService.GetFormulaGroupsEffectived(factoryId);

            return DataGridJsonParser.DataTableToJson(formulaGroups, "KeyID", "Name", "CreateDate", "State", "EffectiveDate", "ExpirationDate");
        }

        [WebMethod]
        public string GetFormulaGroupsPendingEffectivedWithDataGridFormat(int factoryId)
        {
            DataTable formulaGroups = ExpressionService.GetFormulaGroupsPendingEffectived(factoryId);

            return DataGridJsonParser.DataTableToJson(formulaGroups, "KeyID", "Name", "CreateDate", "State", "EffectiveDate", "ExpirationDate");
        }

        [WebMethod]
        public string GetFormulaGroupsPendingExpirationWithDataGridFormat(int factoryId)
        {
            DataTable formulaGroups = ExpressionService.GetFormulaGroupsPendingExpiration(factoryId);

            return DataGridJsonParser.DataTableToJson(formulaGroups, "KeyID", "Name", "CreateDate", "State", "EffectiveDate", "ExpirationDate");
        }

        [WebMethod]
        public string GetFormulasWithTreeGridFormat(string groupId)
        {
            Guid id = new Guid(groupId);
            DataTable formulas = ExpressionService.GetFormulasByGroupId(id);
            DataColumn parentIdColumn = new DataColumn("ParentID");
            formulas.Columns.Add(parentIdColumn);

            foreach (DataRow row in formulas.Rows)
            {
                string levelcode = row["LevelCode"].ToString().Trim();
                if (levelcode.Length > 3)
                    row["ParentID"] = levelcode.Substring(0, levelcode.Length - 2);
            }

            return TreeGridJsonParser.DataTableToJson(formulas, "LevelCode", "ParentID", "Name", "Formula");
        }

        [WebMethod]
        public string GetFormulaName(string groupId)
        {
            Guid id = new Guid(groupId);

            DataTable dt = ExpressionService.GetFormulaGroupInfoByGroupId(id);
            if (dt.Rows.Count > 0)
                return "{\"name\":\"" + dt.Rows[0]["Name"].ToString() + "\"}";
            else
                return "";
        }

        [WebMethod]
        public string GetAmmeterLabelsWithTreeGridFormat(int factoryId)
        {
            DataTable dt = MeterDataDisplayService.GetAmmetersByFactoryId(factoryId);

            return TreeGridJsonParser.DataTableToJson(dt, "ElectricRoom", new string[] { "AmmeterNumber", "AmmeterName" });
        }

        #endregion

        #region Update
        [WebMethod]
        public void UpdateFormulaGroupName(string groupId, string name)
        {
            Guid id = new Guid(groupId);

            ExpressionService.SaveFormulaGroupName(id, name);
        }

        [WebMethod]
        public void SaveFormulasWithTreeGridFormat(string groupId, string json)
        {
            Guid id = new Guid(groupId);
            DataTable dt = TreeGridJsonParser.JsonToDataTable(json.ToString());

            ExpressionService.SaveFormulas(id, dt);
        }
        #endregion

        #region Create
        [WebMethod]
        public string CreateFormulaGroup(int factoryId)
        {
            Guid id = ExpressionService.CreateNewFormulaGroup(factoryId);

            return "{\"groupId\":\"" + id.ToString() + "\"}";
        }

        #endregion
    }
}
