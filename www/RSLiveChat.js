var exec = require('cordova/exec');

var RSLiveChat = function() {};

RSLiveChat.loadLiveChatApi = function (licenseId, groupId, onSuccess, onError) {
    var log = console.log.bind(console);
    exec(onSuccess || log, onError || log, 'RSLiveChat', 'loadLiveChatApi', [licenseId, groupId]);
};

RSLiveChat.displayMessenger = function (onSuccess, onError) {
    var log = console.log.bind(console);
    exec(onSuccess || log, onError || log, 'RSLiveChat', 'displayMessenger', []);
};

module.exports = RSLiveChat;
