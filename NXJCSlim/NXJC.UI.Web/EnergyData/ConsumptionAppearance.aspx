<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsumptionAppearance.aspx.cs" Inherits="NXJC.UI.Web.EnergyData.ConsumptionAppearance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>一分厂能耗总耗图</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div style="position:relative;background-image:url('/Images/ConsumptionAppearance.jpg');background-repeat:no-repeat;width:1167px;height:788px;">
        
        <%--<asp:Label ID="矿山本班用电量" runat="server" style=" position:absolute; text-align:right; top: 20px; left: 123px; width: 147px;"
            Text ="矿山本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ksbbydl" style=" position:absolute; text-align:center; top: 11px; left: 265px; bottom: 753px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="矿山本班产量" runat="server" style=" position:absolute; text-align:right; top: 44px; left: 123px; width: 147px;"
            Text ="矿山本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ksbbcl" style=" position:absolute; text-align:center; top: 35px; left: 265px; bottom: 753px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="矿山本班电耗" runat="server" style=" position:absolute; text-align:right; top: 68px; left: 123px; width: 147px;"
            Text ="矿山本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ksbbdh" style=" position:absolute; text-align:center; top: 59px; left: 265px; bottom: 753px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="烧成系统热效率" runat="server" style=" position:absolute; text-align:right; top: 20px; left: 395px; width: 147px;"
            Text ="烧成系统热效率："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="scxtrxl" style=" position:absolute; text-align:center; top: 11px; left: 538px; bottom: 755px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>--%>

        <asp:Label ID="煤粉低位热值" runat="server" style=" position:absolute; text-align:right; top: 44px; left: 366px; width: 176px;"
            Text ="煤粉低位热值Qnet.ar："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="mfdwrz" style=" position:absolute; text-align:center; top: 35px; left: 538px; bottom: 755px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="本班熟料实物煤耗" runat="server" style=" position:absolute; text-align:right; top: 190px; left: 637px; width: 199px;"
            Text ="本班熟料实物煤耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="bbslswmh" style=" position:absolute; text-align:center; top: 180px; left: 831px; bottom: 584px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="熟料本班产量" runat="server" style=" position:absolute; text-align:right; top: 401px; left: 404px; width: 127px;"
            Text ="熟料本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="slbbcl" style=" position:absolute; text-align:center; top: 390px; left: 528px; bottom: 374px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="本班熟料分步电耗" runat="server" style=" position:absolute; text-align:right; top: 465px; left: 183px; width: 184px; right: 800px;"
            Text ="本班熟料分步电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="bbslfbdh" style=" position:absolute; text-align:center; top: 455px; left: 363px; bottom: 309px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="本班熟料综合电耗" runat="server" style=" position:absolute; text-align:right; top: 489px; left: 183px; width: 184px; right: 800px;"
            Text ="本班熟料综合电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="bbslzhdh" style=" position:absolute; text-align:center; top: 479px; left: 363px; bottom: 309px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="原料磨本班用电量" runat="server" style=" position:absolute; text-align:right; top: 528px; left: 12px; width: 149px; right: 1006px;"
            Text ="原料磨本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ylmbbydl" style=" position:absolute; text-align:center; top: 518px; left: 156px; bottom: 246px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="原料磨本班产量" runat="server" style=" position:absolute; text-align:right; top: 552px; left: 12px; width: 149px; right: 1006px;"
            Text ="原料磨本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ylmbbcl" style=" position:absolute; text-align:center; top: 542px; left: 156px; bottom: 246px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="原料磨本班电耗" runat="server" style=" position:absolute; text-align:right; top: 576px; left: 12px; width: 149px; right: 1006px;"
            Text ="原料磨本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="ylmbbdh" style=" position:absolute; text-align:center; top: 566px; left: 156px; bottom: 246px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨1本班用电量" runat="server" style=" position:absolute; text-align:right; top: 637px; left: 570px; width: 149px; right: 428px;"
            Text ="水泥磨1#本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbydl1" style=" position:absolute; text-align:center; top: 632px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨1本班产量" runat="server" style=" position:absolute; text-align:right; top: 661px; left: 570px; width: 149px; right: 189px;"
            Text ="水泥磨1#本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbcl1" style=" position:absolute; text-align:center; top: 656px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨1本班电耗" runat="server" style=" position:absolute; text-align:right; top: 685px; left: 570px; width: 149px; right: 189px;"
            Text ="水泥磨1#本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbdh1" style=" position:absolute; text-align:center; top: 680px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨2本班用电量" runat="server" style=" position:absolute; text-align:right; top: 709px; left: 570px; width: 149px; right: 428px;"
            Text ="水泥磨2#本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbydl2" style=" position:absolute; text-align:center; top: 704px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨2本班产量" runat="server" style=" position:absolute; text-align:right; top: 733px; left: 570px; width: 149px; right: 189px;"
            Text ="水泥磨2#本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbcl2" style=" position:absolute; text-align:center; top: 728px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨2本班电耗" runat="server" style=" position:absolute; text-align:right; top: 757px; left: 570px; width: 149px; right: 189px;"
            Text ="水泥磨2#本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbdh2" style=" position:absolute; text-align:center; top: 752px; left: 736px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨3本班用电量" runat="server" style=" position:absolute; text-align:right; top: 637px; left: 860px; width: 149px; right: 158px;"
            Text ="水泥磨3#本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbydl3" style=" position:absolute; text-align:center; top: 632px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨3本班产量" runat="server" style=" position:absolute; text-align:right; top: 661px; left: 860px; width: 149px; right: 189px;"
            Text ="水泥磨3#本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbcl3" style=" position:absolute; text-align:center; top: 656px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨3本班电耗" runat="server" style=" position:absolute; text-align:right; top: 685px; left: 860px; width: 149px; right: 189px;"
            Text ="水泥磨3#本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbdh3" style=" position:absolute; text-align:center; top: 680px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨4本班用电量" runat="server" style=" position:absolute; text-align:right; top: 709px; left: 860px; width: 149px; right: 428px;"
            Text ="水泥磨4#本班用电量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbydl4" style=" position:absolute; text-align:center; top: 704px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨4本班产量" runat="server" style=" position:absolute; text-align:right; top: 733px; left: 860px; width: 149px; right: 189px;"
            Text ="水泥磨4#本班产量："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbcl4" style=" position:absolute; text-align:center; top: 728px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="水泥磨4本班电耗" runat="server" style=" position:absolute; text-align:right; top: 757px; left: 860px; width: 149px; right: 189px;"
            Text ="水泥磨4#本班电耗："  Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>
        <asp:TextBox ID="snmbbdh4" style=" position:absolute; text-align:center; top: 752px; left: 1004px; " 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset" ForeColor="#990000" ></asp:TextBox>

        <%--<asp:Label ID="Label1" runat="server" style=" position:absolute; top: 19px; left: 356px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label2" runat="server" style=" position:absolute; top: 43px; left: 356px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label3" runat="server" style=" position:absolute; top: 67px; left: 356px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label4" runat="server" style=" position:absolute; top: 19px; left: 630px;" Text="%" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>--%>
        <asp:Label ID="Label5" runat="server" style=" position:absolute; top: 43px; left: 630px;" Text="kcal" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label6" runat="server" style=" position:absolute; top: 186px; left: 921px;" Text="kg/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label7" runat="server" style=" position:absolute; top: 396px; left: 619px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label8" runat="server" style=" position:absolute; top: 462px; left: 455px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label9" runat="server" style=" position:absolute; top: 486px; left: 455px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label10" runat="server" style=" position:absolute; top: 523px; left: 247px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label11" runat="server" style=" position:absolute; top: 546px; left: 247px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label12" runat="server" style=" position:absolute; top: 570px; left: 247px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label13" runat="server" style=" position:absolute; top: 638px; left: 828px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label14" runat="server" style=" position:absolute; top: 662px; left: 828px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label15" runat="server" style=" position:absolute; top: 686px; left: 828px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label1" runat="server" style=" position:absolute; top: 710px; left: 828px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label2" runat="server" style=" position:absolute; top: 734px; left: 828px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label3" runat="server" style=" position:absolute; top: 758px; left: 828px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label4" runat="server" style=" position:absolute; top: 638px; left: 1095px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label16" runat="server" style=" position:absolute; top: 662px; left: 1095px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label17" runat="server" style=" position:absolute; top: 686px; left: 1095px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>

        <asp:Label ID="Label18" runat="server" style=" position:absolute; top: 710px; left: 1095px;" Text="kwh" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label19" runat="server" style=" position:absolute; top: 734px; left: 1095px;" Text="t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        <asp:Label ID="Label20" runat="server" style=" position:absolute; top: 758px; left: 1095px;" Text="kwh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>


    </div>
    </div>
    </form>
</body>
</html>
