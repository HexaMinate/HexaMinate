var shelljs = require("shelljs");
var autostart = false;
var array = require("./account.json");
for (var index = 0; index < array.length; index++) {
    var loop_data = array[index];
    if (typeof loop_data == "object" && loop_data["is_run"]) {

        if (process.env["skip_update"] != undefined) {
            loop_data["type"] = "skip_update";
        }
        var command = `name=${JSON.stringify(loop_data["name"])} type=${JSON.stringify(loop_data["type"])} ${(loop_data["autostart"]) ? "autostart=true " : ""}${loop_data["is_bot"] ? "./bot.exe" : "./userbot.exe"}`;
        console.log(command);
        shelljs.exec(command, { "async": true }).setMaxListeners(0);
    }
}