import Foundation
import UIKit

@objc public class BluetoothAudioService: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    func getConnectedDevices() {
        
    }
}
