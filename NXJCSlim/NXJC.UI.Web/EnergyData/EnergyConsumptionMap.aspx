<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnergyConsumptionMap.aspx.cs" Inherits="NXJC.UI.Web.EnergyData.EnergyConsumptionMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>宁夏集团能耗</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="position:relative;background-image:url('/Images/Map.JPG'); background-repeat:no-repeat;width:700px;height:855px; top: 5px; left: 321px;">
        <div style="position:absolute;border:3px solid black; top: 222px; left: 283px; width: 287px; height: 195px; background-color:#fff;">
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="宁夏集团能耗" runat="server" Text="宁夏集团能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="ZGL" runat="server" Text=""></asp:Label><asp:Label ID="KWh" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="ZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label1" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="SLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label2" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="SLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label3" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="ZLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label4" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="SNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label5" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="SNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label6" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="SNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label7" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="YRFD" runat="server" Text=""></asp:Label><asp:Label ID="MW" runat="server" Text="MW"></asp:Label>
         </div>
     </div>

        <div style="position:absolute;border:3px solid black;background-color:#fff;width:311px; height:861px; top: 18px; left: 17px;">
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="YC" runat="server" Text="银川水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率 <asp:Label ID="YCZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label9" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗 <asp:Label ID="YCZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label11" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗 <asp:Label ID="YCSLZHDH" runat="server" Text=""></asp:Label>&nbsp;<asp:Label ID="Label13" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗 <asp:Label ID="YCSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label15" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗 <asp:Label ID="YCSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label17" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗 <asp:Label ID="YCSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label19" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗 <asp:Label ID="YCSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label21" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗 <asp:Label ID="YCSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label23" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率 <asp:Label ID="YCSNYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label25" runat="server" Text="MW"></asp:Label>
           

            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="QTX" runat="server" Text="青铜峡水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="QTXZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label71" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="QTXZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label85" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="QTXSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label92" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="QTXSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label96" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="QTXSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label99" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="QTXSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label101" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="QTXSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label103" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="QTXSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label105" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="QTXYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label107" runat="server" Text="MW"></asp:Label>     
           
            
            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="ZN" runat="server" Text="中宁水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="ZNZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label10" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="ZNZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label14" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="ZNSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label18" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="ZNSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label22" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="ZNSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label26" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="ZNSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label28" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="ZNSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label30" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="ZNSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label32" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="ZNSNYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label34" runat="server" Text="MW"></asp:Label>     
        

            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="LPS" runat="server" Text="六盘山水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="LPSZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label12" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="LPSZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label20" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="LPSSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label27" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="LPSSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label31" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="LPSSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label35" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="LPSSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label37" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="LPSSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label39" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="LPSSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label43" runat="server" Text="kgce/t"></asp:Label>
 

            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="SZS" runat="server" Text="石嘴山水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="SZSZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label16" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="SZSZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label29" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="SZSSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label48" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="SZSSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label50" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="SZSSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label52" runat="server" Text="kgce/t"></asp:Label>
          
        </div>

      <div style="position:absolute;border:3px solid black;background-color:#fff;width:311px; height:951px; top: 18px; left: 1031px;">
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="TS" runat="server" Text="天水水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="TSZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label24" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="TSZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label38" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="TSSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label47" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="TSSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label51" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="TSSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label55" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="TSSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label57" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="TSSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label59" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="TSSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label61" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="TSYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label63" runat="server" Text="MW"></asp:Label>     
      

            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="WH" runat="server" Text="乌海赛马公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="WHZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label33" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="WHZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label49" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="WHSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label56" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="WHSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label60" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="WHSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label64" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="WHSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label66" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="WHSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label68" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="WHSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label70" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="WHYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label72" runat="server" Text="MW"></asp:Label>     
           
          
            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="BY" runat="server" Text="白银水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="BYZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label44" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="BYZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label58" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="BYSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label65" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="BYSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label69" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="BYSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label73" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="BYSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label75" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="BYSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label77" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="BYSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label79" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="BYYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label81" runat="server" Text="MW"></asp:Label>     
          

            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="XS" runat="server" Text="乌海西水公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="XSZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label53" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="XSZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label67" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="XSSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label74" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="XSSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label78" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="XSSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label82" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="XSSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label84" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="XSSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label86" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="XSSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label88" runat="server" Text="kgce/t"></asp:Label>
           
          
            <hr />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="KLQ" runat="server" Text="喀喇沁水泥公司能耗" Font-Size="X-Large" ></asp:Label>
            <br />
            &nbsp;总功率<asp:Label ID="KLQZGL" runat="server" Text=""></asp:Label><asp:Label ID="Label40" runat="server" Text="KWh"></asp:Label>
            &nbsp;总电耗<asp:Label ID="KLQZDH" runat="server" Text=""></asp:Label><asp:Label ID="Label62" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:Label ID="KLQSLZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label76" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:Label ID="KLQSLZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label83" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:Label ID="KLQSLZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label87" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:Label ID="KLQSNZHDH" runat="server" Text=""></asp:Label><asp:Label ID="Label91" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:Label ID="KLQSNZHMH" runat="server" Text=""></asp:Label><asp:Label ID="Label93" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:Label ID="KLQSNZHNH" runat="server" Text=""></asp:Label><asp:Label ID="Label95" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:Label ID="KLQYRFD" runat="server" Text=""></asp:Label><asp:Label ID="Label97" runat="server" Text="MW"></asp:Label>     
           
      </div>
    </form>
</body>
</html>
