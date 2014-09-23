using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJC.UI.Web.EnergyData
{
    public partial class EnergyConsumptionMap : System.Web.UI.Page
    {
        private static readonly string CONNECTION_STRING = ConnectionStringFactory.GetNXJCConnectionString();

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> dictionary = new Dictionary<string, string>();

            using (SqlConnection connection = new SqlConnection(CONNECTION_STRING))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = "SELECT * FROM [TEMP_EnergyConsumptionMap]";

                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        dictionary.Add(reader["VariableName"].ToString().Trim(), reader["Value"].ToString());
                    }
                }
            }

            foreach (var key in dictionary.Keys)
            {
                Label label = (Label)this.Page.FindControl(key);
                if (label == null)
                    continue;

                label.Text = dictionary[key];
            }
            
        }
    }
}