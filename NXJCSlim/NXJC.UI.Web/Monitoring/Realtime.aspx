<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Realtime.aspx.cs" Inherits="NXJCSlim.UI.Web.Monitoring.Realtime" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="/Scripts/jquery-1.7.1.min.js"></script>
    <script src="/Scripts/jquery.fullscreen.js"></script>
    <script src="/Scripts/monitoringjs/blink.js"></script>
    <title>实时监控</title>

    <style>
        #templatePlaceHolder.fullScreen {
            /* Give the element a width and margin:0 auto; to center it. */
            width: 100px;
            margin: 0 auto;
        }
    </style>

    <script type="text/javascript">

        var templateUrl = "<%= TemplatePath %>";
        var pollingIntervals = 1000;
        var pollforupdates = true;
        var pollingTimer;

        function displayRunningMessage() {
            // 显示运行信息
            $("#statue").html("<a style=\"color: green;\">运行中</a>");
        }

        function displayPauseMessage() {
            // 显示暂停信息
            $("#statue").html("<a style=\"color: red;\">已暂停</a>");
        }

        function displayErrorMessage() {
            // 显示错误信息
            $("#statue").html("<a style=\"color: red;\">连接失败</a>");
        }

        $(document).ready(function () {
            // 加载模板
            loadTemplate();
            // 文档与模板加载完毕后开始获取最新数据
            //runUpdates();
            getLatestData();

            if ($.support.fullscreen) {
                // Show the full screen button
                $('#btnFullScreen').show();
            }

            // 全屏按钮事件挂载
            $('#btnFullScreen').click(function (e) {
                // Use the plugin
                $('#templatePlaceHolder').fullScreen({
                    'background': '#008C8D',
                });
                $('#templatePlaceHolder.fullScreen').width($('.templatediv').width());
                e.preventDefault();
            });
        });

        function loadTemplate() {
            // 将模板加载至 templatePlaceHolder
            $("#templatePlaceHolder").load(templateUrl);
        }

        function setupPollingIntervals() {
            // 设置轮询时间间隔
            pollingIntervals = parseInt($("#pollingIntervals").val());
            // 重置轮询计数器，以便应用新设置的轮询时间间隔
            resePollingTimeCounter();
        }

        function toggle() {
            // 轮询启停开关
            if (pollforupdates == true) {
                // 当轮询状态为启动时，暂停轮询，并更新按钮文本
                pauseUpdates();
                $("#btnToggle").val("运行");
            }
            else {
                // 当轮询状态为暂停时，启动轮询
                runUpdates();
                $("#btnToggle").val("暂停");
            }
        }

        function pauseUpdates() {
            // 暂停轮询
            pollforupdates = false;
            displayPauseMessage();
        }

        function runUpdates() {
            // 启动轮询
            pollforupdates = true;
            setupPollingIntervals();
            displayRunningMessage();
        }


        function getLatestData() {
            var jsonFoke = '{';
            jsonFoke+='"DataSet":['
            for (var j = 'A'.charCodeAt(); j < 'I'.charCodeAt(); j++) {
                for (var i = 1; i < 40; i++) {
                    jsonFoke += '{"ID":"' + String.fromCharCode(j) + i + '","Value":"' + Math.random() + '"},';
                }
            }
            jsonFoke += '{"test":"1"}]}';
            //$('#testtext').val(jsonFoke);
            serviceSuccessful(jQuery.parseJSON(jsonFoke));
        }

        function serviceFailed(result) {
            if (pollforupdates == true) {
                displayErrorMessage();
                setupTimerToPollLatestData();
            }
        }

        function serviceSuccessful(resultObject) {
            if (pollforupdates == true) {
                displayScene(resultObject);
                setupTimerToPollLatestData();
            }
        }

        function setupTimerToPollLatestData() {
            // 设置获取最新数据定时器
            pollingTimer = setTimeout(
                function () {
                    getLatestData();
                }, pollingIntervals);
        }

        function resePollingTimeCounter() {
            // 停止计时
            clearTimeout(pollingTimer);
            // 重新启动计时
            setupTimerToPollLatestData()
        }

        function displayScene(json) {
            // 显示监控画面参数
            // $("#sceneName").html(scene.Name);
            //var datetime = getDatetimeFromJson(new Date().getTime());
            var datetime = new Date().toLocaleString();
            $("#timestamp").html(datetime);
            
            // 显示数据项
            displayDataItem(json.DataSet);
        }

        function displayDataItem(dataSets) {
            $.each(dataSets, function (i, item) {
                $("#" + item.ID).val(item.Value);
            });

            //SwitchingValueRender();
        }

        function getDatetimeFromJson(jsonDate) {
            // 转换JSON日期至字符串
            jsonDate = jsonDate.split('(')[1].split(')')[0];
            var rDate = new Date(parseInt(jsonDate));
            return rDate.toLocaleString();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size: 85%; position: fixed; top: 0; padding-left: 5px; width: 100%; background: white; height: 30px; z-index: 100;">
            <span id="btnFullScreen" style="display: none;">全屏 | </span><!--画面：<span id="sceneName"></span> | -->时间：<span id="timestamp"></span> | 
            更新间隔：<input id="pollingIntervals" type="text" value="1000" /><input type="button" value="确定" onclick="setupPollingIntervals();" /> | 
            状态：<span id="statue"><a style="color: green;">运行中</a></span> | <input id="btnToggle" type="button" value="暂停" onclick="toggle();" />
            <!--<input type="button" value="tester" onclick="test()" />
            <input id="testtext" type="text" style="width:1000px" />-->
        </div>
        <div id="templatePlaceHolder" style="margin-top: 30px;"></div>
    </form>
</body>
</html>
