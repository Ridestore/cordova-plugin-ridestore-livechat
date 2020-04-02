import LiveChat
import UserNotifications
import Foundation
import UIKit

/**
 * Notes: The @objc shows that this class & function should be exposed to Cordova.
 */
@objc(RSLiveChat) class RSLiveChat : CDVPlugin, LiveChatDelegate {
  @objc(loadLiveChatApi:)
  func loadLiveChatApi(command: CDVInvokedUrlCommand) {
    LiveChat.licenseId = command.arguments[0] as? String ?? "";
    LiveChat.groupId = command.arguments[1] as? String ?? "";
    LiveChat.delegate = self;
    
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Configuration succeeded");
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

  func received(message: LiveChatMessage) {
    print("Received message: \(message.text)");
    if (!LiveChat.isChatPresented) {
      let alert = UIAlertController(title: message.authorName, message: message.text, preferredStyle: .alert);
      let chatAction = UIAlertAction(title: "🙂 Go to chat", style: .default) { alert in
          // Presenting chat if not presented:
          if !LiveChat.isChatPresented {
              LiveChat.presentChat();
          }
      }
      alert.addAction(chatAction);
      
      let cancelAction = UIAlertAction(title: "🤨 Cancel", style: .cancel);
      alert.addAction(cancelAction);
      
      self.viewController.present(alert, animated: true, completion: nil);
      let encodedAuthor = Data(message.authorName.utf8).base64EncodedString();
      let encodedMessage = Data(message.text.utf8).base64EncodedString();
      self.commandDelegate.evalJs("if (window.globalLiveChatMessageHandler) { window.globalLiveChatMessageHandler('\(encodedAuthor)', '\(encodedMessage)'); }");
    }
   }
}
