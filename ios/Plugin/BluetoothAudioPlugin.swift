import Foundation
import Capacitor
import AVFAudio

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(BluetoothAudioPlugin)
public class BluetoothAudioPlugin: CAPPlugin {
    
    public override func load() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    @objc func getConnectedDevices(_ call: CAPPluginCall) {
        let audioSession = AVAudioSession.sharedInstance()
        
        var devicesList = JSArray()
        for device in self.getSupportedDevices(audioSession.currentRoute) {
            devicesList.append(self.deviceToJSObject(device))
        }
        call.resolve([
            "devices": devicesList
        ])
    }
    
    @objc private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        
        let session = AVAudioSession.sharedInstance()
        let currentRoute = session.currentRoute
        let previousRoute = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription
        let currentDevices = self.getSupportedDevices(currentRoute)
        let previousDevices = previousRoute != nil ? self.getSupportedDevices(previousRoute!) : []
        let changes = currentDevices.symmetricDifference(previousDevices)
        
        switch reason {
        case .newDeviceAvailable:
            for device in changes {
                notifyConnectivityStatus(device: device, connected: true)
            }
        case .oldDeviceUnavailable:
            for device in changes {
                notifyConnectivityStatus(device: device, connected: false)
            }
        default: ()
        }
    }
    
    private func notifyConnectivityStatus(device: AVAudioSessionPortDescription, connected: Bool) {
        let obj : JSObject = [
            "device": self.deviceToJSObject(device),
            "connected": connected
        ]
        notifyListeners("connectivity_status", data: obj)
    }
    
    private func getSupportedDevices(_ route: AVAudioSessionRouteDescription) -> Set<AVAudioSessionPortDescription> {
        let supportedPorts = [
            AVAudioSession.Port.bluetoothA2DP,
            AVAudioSession.Port.bluetoothHFP,
            AVAudioSession.Port.bluetoothLE
        ]
        var devices: Set<AVAudioSessionPortDescription> = []
        for device in route.inputs + route.outputs {
            if (supportedPorts.contains(device.portType)) {
                devices.insert(device)
            }
        }
        return devices
    }
    
    private func deviceToJSObject(_ device: AVAudioSessionPortDescription) -> JSObject {
        let obj : JSObject = [
            "name": device.portName ,
            "id": device.uid,
            "address": device.uid,
            "class": device.portType.rawValue
        ]
        return obj
    }
}
