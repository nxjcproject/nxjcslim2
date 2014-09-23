<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="NXJC.UI.Web.EnergyData.Company" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>银川水泥公司能耗</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <div style="position:absolute; top: 5px; left: 487px;"><asp:Label ID="Label1" runat="server" Text="银川水泥公司能耗" Font-Size="XX-Large" ></asp:Label></div>
        <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;line-height:1.5;width:344px; height:301px; top: 52px; left: 12px; margin-right: 0px;" >
            <%--&nbsp;总功率<asp:TextBox ID="YFCZGL1" runat="server" text="" style=" position:absolute; text-align:center; width: 50px;top: 84px;" ></asp:TextBox>KWh<br />
            总电耗<asp:TextBox ID="YFCZDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;top: 84px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label62" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:TextBox ID="YFCSLZHDH" runat="server" text="" style=" position:absolute;text-align:center; width: 64px; right: 157px; top: 111px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label76" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:TextBox ID="YFCSLZHMH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label83" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:TextBox ID="YFCSLZHNH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label87" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:TextBox ID="YFCSNZHDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label91" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:TextBox ID="YFCSNZHMH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label93" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:TextBox ID="YFCSNZHNH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label95" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:TextBox ID="YFCYRFD" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 157px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label97" runat="server" Text="MW"></asp:Label>--%>
            
               
             <asp:Label ID="Label2"  style="text-align:center; font-size: x-large;" runat="server" Width="341px">一分厂能耗</asp:Label>
            
             <table >   
                <tbody>
                    <tr>
                        <td>
                            总功率：
                        </td>
                        <td>
                            <asp:TextBox ID="YFCZGL" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            总电耗：
                        </td>
                        <td>
                            <asp:TextBox ID="YFCZDH" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合电耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSLZHDH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合煤耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSLZHMH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合能耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSLZHNH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合电耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSNZHDH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合煤耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSNZHMH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合能耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCSNZHNH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            余热发电：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="YFCYRFD" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            MW
                        </td>
                    </tr>
                </tbody>
            </table>     
       </div>
       <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;line-height:1.5;width:344px; height:301px; top: 52px; left: 465px;">
           <%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="ND" runat="server" Text="宁东分厂能耗" Font-Size="X-Large" ></asp:Label>
            <br /><br />
            &nbsp;总功率<asp:TextBox ID="NDZGL" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;right: 205px; top: 84px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Text="KWh"></asp:Label>
            &nbsp; 总电耗<asp:TextBox ID="NDZDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; top: 84px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label5" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:TextBox ID="NDSNZHDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label13" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:TextBox ID="NDSNZHMH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label15" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:TextBox ID="NDSNZHNH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label17" runat="server" Text="kgce/t"></asp:Label>
       --%><asp:Label ID="Label3"  style="text-align:center; font-size: x-large;" runat="server" Width="341px">宁东分厂能耗</asp:Label>
            
             <table >   
                <tbody>
                    <tr>
                        <td>
                            总功率：
                        </td>
                        <td>
                            <asp:TextBox ID="NDZGL" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            总电耗：
                        </td>
                        <td>
                            <asp:TextBox ID="NDZDH" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合电耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="NDSNZHDH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合煤耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="NDSNZHMH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合能耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="NDSNZHNH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    
                  </tbody>
            </table>
       </div>
       <div style="position:absolute;border:3px solid black;background-color:#b9b9b9;line-height:1.5;width:344px; height:301px;top: 52px; left: 928px;">
            <%--<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="LS" runat="server" Text="兰山分厂能耗" Font-Size="X-Large" ></asp:Label>
            <br /><br />
            &nbsp;总功率<asp:TextBox ID="LSZGL" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; top: 84px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Text="KWh"></asp:Label>
            &nbsp; 总电耗<asp:TextBox ID="LSZDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; top: 84px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="KWh"></asp:Label>
            <br />&nbsp;熟料综合电耗<asp:TextBox ID="LSSLZHDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label6" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;熟料综合煤耗<asp:TextBox ID="LSSLZHMH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label7" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;熟料综合能耗<asp:TextBox ID="LSSLZHNH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px;"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label8" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合电耗<asp:TextBox ID="LSSNZHDH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label9" runat="server" Text="kWh/t"></asp:Label>
            <br />&nbsp;水泥综合煤耗<asp:TextBox ID="LSSNZHMH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label10" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;水泥综合能耗<asp:TextBox ID="LSSNZHNH" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label11" runat="server" Text="kgce/t"></asp:Label>
            <br />&nbsp;余热发电功率<asp:TextBox ID="LSYRFD" runat="server" text="" style=" position:absolute; text-align:center; width: 64px; "></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label12" runat="server" Text="MW"></asp:Label>     
       --%>
           <asp:Label ID="Label4"  style="text-align:center; font-size: x-large;" runat="server" Width="341px">兰山分厂能耗</asp:Label>
            
             <table >   
                <tbody>
                    <tr>
                        <td>
                            总功率：
                        </td>
                        <td>
                            <asp:TextBox ID="LSZGL" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            总电耗：
                        </td>
                        <td>
                            <asp:TextBox ID="LSZDH" runat="server" style="width:45px;" ></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合电耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSLZHDH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合煤耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSLZHMH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            熟料综合能耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSLZHNH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合电耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSNZHDH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            KWh
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合煤耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSNZHMH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            水泥综合能耗：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSSNZHNH" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            kgce/t
                        </td>
                    </tr>
                    <tr>
                        <td>
                            余热发电：
                        </td>
                        <td style="width:30px;">
                            <asp:TextBox ID="LSYRFD" runat="server" text="" style="width: 45px;"></asp:TextBox>
                        </td>
                        <td>
                            MW
                        </td>
                    </tr>
                </tbody>
            </table> 
       </div>
    
    </div>
    </form>
</body>
</html>
