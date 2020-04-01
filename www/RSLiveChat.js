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

RSLiveChat.updateUserName = function (name, onSuccess, onError) {
    var log = console.log.bind(console);
    exec(onSuccess || log, onError || log, 'RSLiveChat', 'updateUserName', [name]);
};

RSLiveChat.updateUserEmail = function (email, onSuccess, onError) {
    var log = console.log.bind(console);
    exec(onSuccess || log, onError || log, 'RSLiveChat', 'updateUserEmail', [email]);
};

module.exports = RSLiveChat;
