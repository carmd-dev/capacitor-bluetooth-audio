import Foundation
import Capacitor
import AVFAudio

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(BluetoothAudioPlugin)
public class BluetoothAudioPlugin: CAPPlugin {
    
    var connectedDevices: Set<AVAudioSessionPortDescription> = [];
    
    public override func load() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
        
        self.connectedDevices = self.getSupportedDevices()
    }

    @objc func isAudioPlaying(_ call: CAPPluginCall) {
        let audioSession = AVAudioSession.sharedInstance()
        call.resolve([
            "isAudioPlaying": audioSession.isOtherAudioPlaying
        ]);
    }
    
    @objc func getConnectedDevices(_ call: CAPPluginCall) {
        var devicesList = JSArray()
        
        self.connectedDevices = self.getSupportedDevices()
        for device in self.connectedDevices {
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
        
        let previousDevices = self.connectedDevices;
        let currentDevices = self.getSupportedDevices()
        self.connectedDevices = currentDevices;
        
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
    
    private func getSupportedDevices() -> Set<AVAudioSessionPortDescription> {
        let supportedPorts = [
            AVAudioSession.Port.bluetoothA2DP,
            AVAudioSession.Port.bluetoothHFP,
            AVAudioSession.Port.bluetoothLE
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, options: .allowBluetooth)
        } catch {
            print(error)
        }
        
        let allAvailableDevices = audioSession.currentRoute.inputs 
            + audioSession.currentRoute.outputs
            + (audioSession.availableInputs ?? [])
        var devices: Set<AVAudioSessionPortDescription> = []
        for device in allAvailableDevices {
            if (supportedPorts.contains(device.portType) && !devices.contains(where: { d in
                self.getDeviceUniqueId(d) == self.getDeviceUniqueId(device)
            })) {
                devices.insert(device)
            }
        }
        
        return devices
    }
    
    private func getDeviceUniqueId(_ device: AVAudioSessionPortDescription) -> String {
        let arr = device.uid.components(separatedBy: "-");
        if (arr.count > 0) {
            return arr[0];
        }
        return device.uid;
    }
    
    private func deviceToJSObject(_ device: AVAudioSessionPortDescription) -> JSObject {
        let obj : JSObject = [
            "name": device.portName ,
            "id": device.uid,
            "address": self.getDeviceUniqueId(device),
            "class": device.portType.rawValue
        ]
        return obj
    }
}
