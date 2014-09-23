using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace NXJC.UI.Web.EasyUIDataGrid
{
    public class DataGridTemplateHelper
    {
        //private static readonly ExportFileForWeb.ExportExcel Extend_ExportExcel = new ExportFileForWeb.ExportExcel();

        public static string GetDataGridTemplate(DataTable table, DataGridColumnType columns)
        {
            string m_ValidTreeJson = "";
            string[] m_ColumnText = columns.ColumnText;// = new string[] { "KeyID", "number", "Energy" };
            int[] m_ColumnWidth = columns.ColumnWidth;// = new int[] { 180, 230, 130 };
            string[] m_FormatString = columns.ColumnType;// = new string[] { "", "\"type\":\"text\"", "\"type\":\"numberbox\", \"options\":{\"precision\":\"2\"}" };//"\"type\":\"numberbox\", \"options\":{\"precision\":\"2\"}", "", "", "\"type\":\"checkbox\", \"options\":{\"on\":\"True\",\"off\":\"False\"}", "\"type\":\"text\"" };


            DataTable m_DataTableUserInfo = table;
            List<Model_GridColumnType> m_Model_GridColumnTypeList = new List<Model_GridColumnType>(1);

            for (int i = 0; i < m_DataTableUserInfo.Columns.Count; i++)
            {
                Model_GridColumnType m_Model_GridColumnType = new Model_GridColumnType();
                m_Model_GridColumnType.ColumnText = m_ColumnText[i];
                m_Model_GridColumnType.ColumnWidth = m_ColumnWidth[i];
                m_Model_GridColumnType.FormatString = m_FormatString[i];
                m_Model_GridColumnTypeList.Add(m_Model_GridColumnType);
            }
            m_ValidTreeJson = DataTableToJson(m_DataTableUserInfo, m_Model_GridColumnTypeList);
            return m_ValidTreeJson;
        }

        public static string DataTableToJson(DataTable dt, List<Model_GridColumnType> myGridColumnType)
        {
            StringBuilder Json = new StringBuilder();
            Json.Append("{\"total\":" + dt.Rows.Count + ",");
            Json.Append("\"rows\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":\"" + dt.Rows[i][j].ToString() + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("],\"columns\":[");
            for (int i = 0; i < myGridColumnType.Count; i++)
            {
                Json.Append("{");
                Json.Append("\"width\":\"" + myGridColumnType[i].ColumnWidth + "\"");
                Json.Append(", \"title\":\"" + myGridColumnType[i].ColumnText + "\"");
                Json.Append(", \"field\":\"" + dt.Columns[i].ColumnName.ToString() + "\"");
                if (myGridColumnType[i].FormatString != "")
                {
                    Json.Append(", \"editor\":{" + myGridColumnType[i].FormatString + "}");
                }

                Json.Append("}");
                if (i < myGridColumnType.Count - 1)
                {
                    Json.Append(",");
                }
            }
            Json.Append("]}");
            return Json.ToString();
        }

        //public static void OutExcelStream(string myJsonData)
        //{
        //    Extend_ExportExcel.OutExcelStream(myJsonData);
        //}
    }

    public class Model_GridColumnType
    {
        public Model_GridColumnType()
        { }

        public string ColumnId { get; set; }
        public string ColumnText { get; set; }
        public int ColumnWidth { get; set; }
        public string FormatString { get; set; }
    }

    public class DataGridColumnType
    {
        public string[] ColumnText { get; set; }
        public int[] ColumnWidth { get; set; }
        public string[] ColumnType { get; set; }
    }
}