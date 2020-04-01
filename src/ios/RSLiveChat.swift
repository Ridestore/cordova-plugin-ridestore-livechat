import LiveChat

/**
Notifying the user about the agent's response
You can notifiy your user about agent response if chat was minimized by the user. To handle the incoming messages, your class must implement LiveChatDelegate protocol and set itself as LiveChat.delegate.

class YOUR_CLASS_NAME : LiveChatDelegate { // Your class need to implement LiveChatDelegate protocol
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		LiveChat.licenseId = "YOUR_LICENSE_ID"
		LiveChat.delegate = self // Set self as delegate

		return true
	}

	func received(message: LiveChatMessage) {
		print("Received message: \(message.text)")
		// Handle message here
	}
}
*/

/**
if (!LiveChat.isChatPresented) {
            // Notifying user
            let alert = UIAlertController(title: "Support", message: message.text, preferredStyle: .alert)
            let chatAction = UIAlertAction(title: "Go to Chat", style: .default) { alert in
                // Presenting chat if not presented:
                if !LiveChat.isChatPresented {
                    LiveChat.presentChat()
                }
            }
            alert.addAction(chatAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
*/

/**
 * Notes: The @objc shows that this class & function should be exposed to Cordova.
 */
@objc(RSLiveChat) class RSLiveChat : CDVPlugin, LiveChatDelegate {
  @objc(loadLiveChatApi:)
  func loadLiveChatApi(command: CDVInvokedUrlCommand) {
    LiveChat.licenseId = command.arguments[0] as? String ?? "";
    LiveChat.groupId = command.arguments[1] as? String ?? "";
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Configuration succeeded");
    // var pluginResult = CDVPluginResult (status: CDVCommandStatus_ERROR, messageAs: "Configuration failed");
    // if (LiveChat.licenseId?.count)! > 0 {
    //     // LiveChat.delegate = self;
    //     // UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay ]) {
    //     //     (granted, error) in
    //     //     print("Permission granted: \(granted)")
    //     //     guard granted else { return }
    //     //     self.getNotificationSettings()
    //     // }
    //     pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Configuration succeeded");
    // }
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
  }

  @objc(updateUserName:)
  func updateUserName(command: CDVInvokedUrlCommand) {
    LiveChat.name = command.arguments[0] as? String ?? "";
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "User name update succeeded");
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
  }

  @objc(updateUserEmail:)
  func updateUserEmail(command: CDVInvokedUrlCommand) {
    LiveChat.email = command.arguments[0] as? String ?? "";
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "User email update succeeded");
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
  }

  @objc(displayMessenger:)
  func displayMessenger(command: CDVInvokedUrlCommand) {
    LiveChat.presentChat();
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "displayMessenger succeeded, licenseId: " + (LiveChat.licenseId ?? ""));
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId);
  }

//   func received(message: LiveChatMessage) {
//     print("Received message: \(message.text)");
//     // Handle message here
//     let push = PFPush();
//     push.setChannel("News");
//     push.setMessage("Push From Device");
//     push.sendInBackground();
//   }
}
