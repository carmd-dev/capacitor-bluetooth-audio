import { WebPlugin } from '@capacitor/core';
export class BluetoothAudioWeb extends WebPlugin {
    async getConnectedDevices() {
        return {
            devices: []
        };
    }
}
//# sourceMappingURL=web.js.map