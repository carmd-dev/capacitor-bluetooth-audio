import { WebPlugin } from '@capacitor/core';
export class BluetoothAudioWeb extends WebPlugin {
    async getConnectedDevices() {
        return {
            devices: [],
        };
    }
    addListener(eventName, listenerFunc) {
        console.log('removeAllListeners');
        throw this.unimplemented('Not implemented on web.' + eventName + listenerFunc);
    }
    removeAllListeners() {
        console.log('removeAllListeners');
        throw this.unimplemented('Not implemented on web.');
    }
    async isAudioPlaying() {
        return {
            isAudioPlaying: true,
        };
    }
}
//# sourceMappingURL=web.js.map