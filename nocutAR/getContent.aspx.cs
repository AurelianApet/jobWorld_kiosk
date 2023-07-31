using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using jobworld.Common;
using System.Net;
using System.IO;

namespace jobworld
{
    public partial class getContent : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(Request.Params["type"]))
            {
                return;
            }
            string type = Request.Params["type"];

            if(type == "0")
            {
                if (string.IsNullOrEmpty(Request.Params["id"]))
                {
                    return;
                }
                string id = Request.Params["id"];

                string query = "select * from completeArticles where id=" + id + " order by regdate desc";
                PageDataSource = DBConn.RunSelectQuery(query);
                if (PageDataSource.Tables[0].Rows.Count > 0)
                {
                    string savepath = conPath + PageDataSource.Tables[0].Rows[0][2].ToString().Replace(@"\", @"/");
                    Response.Write(savepath);
                }
            }
            else if(type == "1")
            {
                string query = "select * from completeArticles where kiosk=1 and exist=1 order by regdate desc";
                PageDataSource = DBConn.RunSelectQuery(query);
                string res = "";
                if (PageDataSource.Tables[0].Rows.Count > 0)
                {
                    for(int i = 0; i < PageDataSource.Tables[0].Rows.Count; i ++)
                    {
                        string id = PageDataSource.Tables[0].Rows[i][0].ToString();
                        res += id + ",";
                    }
                    Response.Write(res);
                }
            }
            else if(type == "2")
            {
                string query = "select max(id) from kiosk_log";
                PageDataSource = DBConn.RunSelectQuery(query);
                try
                {
                    int id = Convert.ToInt32(PageDataSource.Tables[0].Rows[0][0].ToString());
                    Response.Write(id);
                }
                catch(Exception)
                {
                    Response.Write("0");
                }
            }
        }
    }
}
