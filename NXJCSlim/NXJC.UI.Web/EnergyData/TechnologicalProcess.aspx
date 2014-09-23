<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechnologicalProcess.aspx.cs" Inherits="NXJC.UI.Web.EnergyData.TechnologicalProcess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>一分厂生产总耗图</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="position:relative;background-image:url('/Images/TechnologicalProcess.jpg');background-repeat:no-repeat;width:1438px;height:851px;">
    
    <asp:Label ID="生料台产" runat="server" 
        
          style=" position:absolute; text-align:right; top: 293px; left: 494px; width: 98px;" Text="生料台产：" 
        Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>

    <asp:TextBox ID="sltc" style=" position:absolute; text-align:center; top: 285px; left: 589px; bottom: 215px;" 
            runat="server" Height="18px" Width="80px" BorderStyle="Outset"
          ForeColor="#990000" ></asp:TextBox>
    
    <asp:Label ID="砂岩比例" runat="server" 
        
          style=" position:absolute; text-align:right; top: 83px; left: 1004px; width: 98px;" Text="砂岩比例：" 
        Font-Size="Small" Font-Bold="True" ForeColor="Blue" Height="13px"></asp:Label>

    <asp:TextBox ID="sybl" style=" position:absolute; text-align:center; top: 78px; left: 1097px; bottom: 473px;" 
            runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>
      
    
    <asp:Label ID="碎石比例" runat="server" 
           style=" position:absolute; text-align:right; top: 106px; left: 1004px; width: 98px;" Text="碎石比例：" 
            Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

    <asp:TextBox ID="ssbl" style=" position:absolute; text-align:center; top: 101px; left: 1097px; bottom: 450px;" 
            runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>
 
    
    <asp:Label ID="铁粉比例" runat="server" 
            
          style=" position:absolute; text-align:right; top: 129px; left: 1004px; width: 98px;" Text="铁粉比例：" 
            Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

    <asp:TextBox ID="tfbl" style=" position:absolute; text-align:center; top: 124px; left: 1097px; bottom: 343px;" 
            runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>
 
    
    <asp:Label ID="页岩比例" runat="server" 
            
          style=" position:absolute; text-align:right; top: 152px; left: 1005px; width: 98px; height: 13px;" Text="页岩比例：" 
            Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

    <asp:TextBox ID="yybl" style=" position:absolute; text-align:center; top: 147px; left: 1097px; bottom: 371px;" 
            runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="辊压机功率" runat="server"  
          
          style=" position:absolute; text-align:right; top: 422px; left: 731px; width: 98px; height: 13px;" Text="辊压机功率：" 
            Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="gyjgl" style=" position:absolute; text-align:center; top: 413px; left: 826px; bottom: 414px;" 
                runat="server" Height="18px" Width="80px" BorderStyle="Outset"
          ForeColor="#990000"></asp:TextBox>
    
        <asp:Label ID="出磨提升电流" runat="server"            
          
          style=" position:absolute; text-align:right; top: 321px; left: 555px; width: 98px; height: 13px; right: 640px;" Text="出磨提升电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="cmtsdl" style=" position:absolute; text-align:center; top: 318px; left: 648px; right: 1092px;" 
                runat="server" Height="18px" Width="80px" BorderStyle="Outset"
          ForeColor="#990000"></asp:TextBox>

        <asp:Label ID="入库提升电流" runat="server"            
          
          style=" position:absolute; text-align:right; top: 365px; left: 463px; width: 98px; height: 13px; " Text="入库提升电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="rktsdl" style=" position:absolute; text-align:center; top: 354px; bottom: 373px; left: 555px;" 
                runat="server" Height="18px" Width="80px" BorderStyle="Outset"
          ForeColor="#990000" ></asp:TextBox>

        <asp:Label ID="煤磨喂煤量" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 210px; left: 241px; width: 98px; height: 13px; right: 954px;" Text="喂煤量：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="mmwml" style=" position:absolute; text-align:center; top: 208px; bottom: 318px; left: 334px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True" ></asp:TextBox>

        <asp:Label ID="煤磨电机功率" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 233px; left: 241px; width: 98px; height: 13px; right: 954px;" Text="电机功率：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="mmdjgl" style=" position:absolute; text-align:center; top: 230px; left: 334px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="煤磨风机电流" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 256px; left: 241px; width: 98px; height: 13px; right: 954px;" Text="煤磨风机电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="mmfjdl" style=" position:absolute; text-align:center; top: 253px; bottom: 273px; left: 334px;" 
                runat="server" Height="18px" Width="80px"  
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>
        
        <asp:Label ID="入窑生料喂料" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 482px; left: 463px; width: 98px; height: 13px; right: 1267px;" Text="入窑生料喂料：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="ryslwl" style=" position:absolute; text-align:center; top: 473px; bottom: 264px; left: 555px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑尾烟室温度" runat="server"             
          
          style=" position:absolute; text-align:right;  top: 672px; left: 188px; width: 98px; height: 13px;" Text="窑尾烟室温度：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="ywyswd" style=" position:absolute; text-align:center; top: 665px; bottom: 72px; left: 284px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑尾烟室压力" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 695px; left: 188px;  width: 98px; height: 13px; right: 1540px;" Text="窑尾烟室压力：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="ywysyl" style=" position:absolute; text-align:center;  top: 689px; bottom: 48px; right: 1456px; left: 284px;" 
                runat="server" Height="18px" Width="80px"
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑二次风温" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 719px; left: 188px; width: 98px; height: 13px;" Text="窑二次风温：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yecfw" style=" position:absolute; text-align:center;  top: 712px; bottom: 25px; right: 1456px; left: 284px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑二次风压" runat="server"             
          
          
          style=" position:absolute; text-align:right; top: 743px; left: 188px; width: 98px; height: 13px; right: 1542px; " Text="窑二次风压：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yecfy" style=" position:absolute; text-align:center;  top: 735px; bottom: 2px; left: 284px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑三次风压" runat="server"             
         style=" position:absolute; text-align:right; text-align:right; top: 767px; left: 188px; width: 98px; height: 13px; right: 1542px;" Text="窑三次风压：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yscfy" style=" position:absolute; text-align:center; top: 759px; left: 284px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>
       
        <asp:Label ID="窑头喂煤量" runat="server"              
          
          style=" position:absolute; text-align:right; top: 646px; left: 419px; width: 98px; height: 13px; " Text="窑头喂煤量：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="ytwml" style=" position:absolute; text-align:center; top: 639px; bottom: 88px; left:514px; right: 1226px; " 
                runat="server" Height="18px" Width="80px"  
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑主电机速度" runat="server"               
            style=" position:absolute; text-align:right; top: 667px; left: 419px; width: 98px; height: 13px; right: 1310px;" Text="窑主电机速度：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yzdjsd" style=" position:absolute; text-align:center; top: 662px; bottom: 65px; left:514px; right: 1227px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="窑主电机电流" runat="server"               
            style=" position:absolute; text-align:right; top: 693px; left: 419px; width: 98px; height: 13px; right: 1311px;" Text="窑主电机电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="ytzdjdl" style=" position:absolute; text-align:center; top: 686px; left:514px; right: 1226px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="高温风机转速" runat="server"               
            style=" position:absolute; text-align:right; top: 717px; left: 419px; width: 98px; height: 13px; right: 1311px;" Text="高温风机转速：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="gwfjzs" style=" position:absolute; text-align:center; top: 709px; left:514px; right: 1226px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="篦冷二室风压" runat="server"               
            style=" position:absolute; text-align:right; top: 740px; left: 419px; width: 98px; height: 13px; " Text="篦冷二室风压：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="blesfy" style=" position:absolute; text-align:center; top: 732px; bottom: -5px; left:514px; right: 1226px;" 
                runat="server" Height="18px" Width="80px"  
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="分解炉出温" runat="server"                
            style=" position:absolute; text-align:right; top: 333px; left: 19px; width: 98px; height: 13px; right: 1174px; margin-top: 0px; bottom: 173px;" Text="分解炉出温：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="fjlcw" style=" position:absolute; text-align:center; text-align:center; top: 327px; bottom: 221px; left:113px; " 
                runat="server" Height="18px" Width="80px"
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True" ></asp:TextBox>
        
        <asp:Label ID="一级筒A出温" runat="server"                
          
          
          style=" position:absolute; text-align:right; top: 379px; left: 19px; width: 98px; height: 13px; right: 1176px;" Text="一级筒A出温：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yjtAcw" style=" position:absolute; text-align:center; top: 373px; bottom: 152px; left:113px; " 
                runat="server" Height="18px" Width="80px"  
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="一级筒A出压" runat="server"                
          
          style=" position:absolute; text-align:right; top: 402px; left: 19px; width: 98px; height: 13px; right: 1176px;" Text="一级筒A出压：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yjtAcy" style=" position:absolute; text-align:center; top: 396px; bottom: 152px; left:113px; " 
                runat="server" Height="18px" Width="80px"  
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="一级筒B出温" runat="server"                
          
          style=" position:absolute; text-align:right; top: 425px; left: 19px; width: 98px; height: 13px; right: 1314px;" Text="一级筒B出温：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="yjtBcw" style=" position:absolute; text-align:center; top: 419px; bottom: 475px; left:113px; " 
                runat="server" Height="18px" Width="80px"
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="增湿塔出压" runat="server"                
          
          style=" position:absolute; text-align:right; top: 356px; left: 19px; width: 98px; height: 13px; right: 1320px;" Text="增湿塔出压：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="zstcy" style=" position:absolute; text-align:center; top: 350px; bottom: 452px; left:113px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="电收尘入温" runat="server"                
          
          style=" position:absolute; text-align:right; top: 516px; left: 19px; width: 98px; height: 13px; right: 1351px;" Text="电收尘入温：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="dscrw" style=" position:absolute; text-align:center; top: 508px; bottom: 319px; left:113px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <%--新加--%>
        <asp:Label ID="风机电流" runat="server"                
          
          style=" position:absolute; text-align:right; top: 544px; left: 951px; width: 98px; height: 13px; right: 779px;" Text="风机电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="fjdl" style=" position:absolute; text-align:center; top: 536px; bottom: 201px; left:1048px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>


        <asp:Label ID="水泥综合电耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 750px; left: 998px; width: 98px; height: 13px; right: 372px;" Text="水泥综合电耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="snzhdh" style=" position:absolute; text-align:center; top: 740px; bottom: 87px; left:1093px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="水泥综合煤耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 771px; left: 998px; width: 98px; height: 13px;" Text="水泥综合煤耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="snzhmh" style=" position:absolute; text-align:center; top: 761px; bottom: 82px; left:1093px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="水泥综合能耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 792px; left: 998px; width: 98px; height: 13px; " Text="水泥综合能耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="snzhnh" style=" position:absolute; text-align:center; top: 782px; bottom: 60px; left:1093px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="高温风机电流" runat="server"                
          
          style=" position:absolute; text-align:right; top: 611px; left: 131px; width: 128px; height: 13px; " Text="高温风机电流：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="gwfjdl" style=" position:absolute; text-align:center; top: 604px; bottom: 223px; left:257px; right: 1083px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>


        <asp:Label ID="熟料综合电耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 721px; left: 646px; width: 128px; height: 13px; " Text="熟料综合电耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="slzhdh" style=" position:absolute; text-align:center; top: 711px; bottom: 46px; left:771px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="熟料综合煤耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 742px; left: 645px; width: 128px; height: 13px; " Text="熟料综合煤耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="slzhmh" style=" position:absolute; text-align:center; top: 733px; bottom: 24px; left:771px; " 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>

        <asp:Label ID="熟料综合能耗" runat="server"                
          
          style=" position:absolute; text-align:right; top: 761px; left: 646px; width: 128px; height: 13px; " Text="熟料综合能耗：" 
                Font-Size="Small" Font-Bold="True" ForeColor="Blue"></asp:Label>

        <asp:TextBox ID="slzhnh" style=" position:absolute; text-align:center; top: 754px; bottom: 3px; left:771px;" 
                runat="server" Height="18px" Width="80px" 
          BorderStyle="Outset" Font-Bold="True" ForeColor="#990000" ReadOnly="True"></asp:TextBox>


      <asp:Label ID="Label20" runat="server" 
          style=" position:absolute; top: 717px; left: 861px;" Text="kWh/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
      
      <asp:Label ID="Label26" runat="server" 
          style=" position:absolute; top: 737px; left: 861px;" Text="kgce/t" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
      <asp:Label ID="Label34" runat="server" 
          style=" position:absolute; top: 757px; left: 861px;" Text="kgce/t" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
                
      <asp:Label ID="Label29" runat="server" 
          style=" position:absolute; top: 785px; left: 1183px;" Text="kgce/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>


      <asp:Label ID="Label3" runat="server" 
          style=" position:absolute; top: 765px; left: 1183px; width: 42px; height: 13px;" Text="kgce/t" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
      
      <asp:Label ID="Label13" runat="server" 
          style=" position:absolute; top: 609px; left: 347px;" Text="A" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label5" runat="server" 
          style=" position:absolute; top: 210px; left: 426px;" Text="t/h" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label8" runat="server" 
          style=" position:absolute; top: 237px; left: 426px;" Text="kw/h" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label7" runat="server" 
          style=" position:absolute; top: 745px; left: 1183px;" Text="kWh/t" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>


      <asp:Label ID="Label2" runat="server" 
          style=" position:absolute; top: 258px; left: 426px; right: 1032px;" Text="A" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>        
                
      <asp:Label ID="Label24" runat="server" 
          style=" position:absolute; top: 333px; left: 201px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
      
        <asp:Label ID="Label1" runat="server" 
          style=" position:absolute; top: 543px; left: 1140px;" Text="A" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label25" runat="server" 
          style=" position:absolute; top: 672px; left: 372px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label19" runat="server" 
          style=" position:absolute; top: 427px; left: 202px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label27" runat="server" 
          style=" position:absolute; top: 404px; left: 203px;" Text="Pa" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label21" runat="server" 
          style=" position:absolute; top: 386px; left: 201px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label28" runat="server" 
          style=" position:absolute; top: 357px; left: 203px;" Text="Pa" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label22" runat="server" 
          style=" position:absolute; top: 517px; left: 201px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label6" runat="server" 
          style=" position:absolute; top: 480px; left: 646px; bottom: 353px;" Text="t/h" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label18" runat="server" 
          style=" position:absolute; top: 719px; left: 372px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label16" runat="server" 
          style=" position:absolute; top: 698px; left: 371px;" Text="℃" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label30" runat="server" 
          style=" position:absolute; top: 765px; left: 373px;" Text="Pa" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label31" runat="server" 
          style=" position:absolute; top: 740px; left: 374px;" Text="Pa" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label15" runat="server" 
          style=" position:absolute; top: 644px; left: 603px;" Text="t/h" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label11" runat="server" 
          style=" position:absolute; top: 666px; left: 603px; height: 17px; width: 39px;" Text="r/min" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label9" runat="server" 
          style=" position:absolute; top: 692px; left: 603px; width: 5px;" Text="A" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label14" runat="server" 
          style=" position:absolute; top: 714px; left: 603px;" Text="r/min" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label32" runat="server" 
          style=" position:absolute; top: 740px; left: 603px;" Text="Pa" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label33" runat="server" 
          style=" position:absolute; top: 291px; left: 679px;" Text="t/h" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label4" runat="server" 
          style=" position:absolute; top: 324px; left: 738px;" Text="A" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label10" runat="server" 
          style=" position:absolute; top: 362px; left: 646px; height: 14px; width: 12px;" Text="A" Font-Bold="True" 
          Font-Size="Small" ForeColor="Blue"></asp:Label>
        
                
      <asp:Label ID="Label17" runat="server" 
          style=" position:absolute; top: 419px; left: 917px;" Text="kw" 
          Font-Bold="True" Font-Size="Small" ForeColor="Blue"></asp:Label>


  

    &nbsp;</div>
    </form>
</body>
</html>
