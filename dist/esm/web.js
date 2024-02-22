import { WebPlugin } from '@capacitor/core';
export class BluetoothAudioWeb extends WebPlugin {
    async getConnectedDevices() {
        return {
            devices: []
        };
    }
    async isAudioPlaying() {
        return {
            isAudioPlaying: true
        };
    }
}
//# sourceMappingURL=web.js.map