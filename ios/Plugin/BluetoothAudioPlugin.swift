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
            try audioSession.setCategory(.record, options: .allowBluetooth)
        } catch {
            print(error)
        }
        
        var devices: Set<AVAudioSessionPortDescription> = []
        if let inputs = audioSession.availableInputs {
            for device in inputs {
                if (supportedPorts.contains(device.portType)) {
                    devices.insert(device)
                }
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
