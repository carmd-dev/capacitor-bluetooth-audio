import { registerPlugin } from '@capacitor/core';
const BluetoothAudio = registerPlugin('BluetoothAudio', {
    web: () => import('./web').then(m => new m.BluetoothAudioWeb()),
});
export * from './definitions';
export { BluetoothAudio };
//# sourceMappingURL=index.js.map