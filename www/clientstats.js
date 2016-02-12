/*global cordova, module*/

var exec = require("cordova/exec")

var ClientStats = {
    LOG_TABLE: "logTable",
    KEY_ID: "ID",
    KEY_TS: "ts",
    KEY_LEVEL: "level",
    KEY_MESSAGE: "message",

    LEVEL_DEBUG: "DEBUG",
    LEVEL_INFO: "INFO",
    LEVEL_WARN: "WARN",
    LEVEL_ERROR: "ERROR",

    /*
     * If this is not done, then we may read read the table before making any
     * native calls, and on iOS, that will cause us to create a loggerDB
     * instead of copying the template.
     */
    init: function() {
        ClientStats.db = window.sqlitePlugin.openDatabase({
            name: "clientStatsDB",
            location: 0,
            createFromLocation: 1
        })
    },

    storeEventNow: function (key, errorCallback) {
        exec(null, errorCallback, 'ClientStats', 'storeEventNow', [key, errorCallback]);
    },

    storeMeasurementNow: function (key, value, errorCallback) {
        ClientStats.storeMeasurement(key, value, moment().format("X"), errorCallback);
    },

    storeMeasurement: function (key, value, ts, errorCallback) {
        exec(null, errorCallback, "ClientStats", "storeMeasurement", [key, value, ts]);
    },
}

module.exports = ClientStats;
