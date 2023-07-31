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
    public partial class Default : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            string query = "select * from completeArticles where exist=1 and kiosk=1 order by regdate desc";
            PageDataSource = DBConn.RunSelectQuery(query);
            if(PageDataSource.Tables[0].Rows.Count > 0)
            {			    
                showcontentList.Text = "";
                for(int i = 0; i < PageDataSource.Tables[0].Rows.Count; i ++)
                {
                    int id = Convert.ToInt32(PageDataSource.Tables[0].Rows[i][0].ToString());
                    string imagepath = PageDataSource.Tables[0].Rows[i][9].ToString();
                    showcontentList.Text += "<li id='li"
                        + i
                        + "'>"
                        + "<div class='ar'>"
                        + "<a onclick = 'onShowContentClick("
                        + i
                        + ", "
                        + id
                        + ")' style = 'cursor:pointer' >"
                        + "<img src = '"
                         + imagePath + imagepath
                        + "' style='width:164px;height:251px;' alt=''>"
                        + "</div>"
                        + "</a></li>";
                }
/*
                if(PageDataSource.Tables[0].Rows.Count < 3)
                {
                    int ct = 3 - PageDataSource.Tables[0].Rows.Count;
                    for(int i = 0; i < ct; i ++)
                    {
                        showcontentList.Text += "<li class='on'>"
                            + "<div class='ar'>"
                            + "<a>"
                            + "<img src = '../images/img_key2.gif' alt=''>"
                            + "</div>"
                            + "</a></li>";
                    }
                }
*/
            }            
        }
    }
}
