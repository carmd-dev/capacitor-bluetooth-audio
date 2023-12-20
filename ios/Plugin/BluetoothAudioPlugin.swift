import Foundation
import Capacitor
import AVFAudio

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(BluetoothAudioPlugin)
public class BluetoothAudioPlugin: CAPPlugin {

    @objc func echo(_ call: CAPPluginCall) {
        /*let value = call.getString("value") ?? ""
        call.resolve([
            "value": bluetoothService.echo(value)
        ])*/
    }
    
    @objc func getConnectedDevices(_ call: CAPPluginCall) {
        let audioSession = AVAudioSession.sharedInstance()
        if let devices = audioSession.availableInputs {
            for device in devices {
                
            }
        }
        
    }
}
