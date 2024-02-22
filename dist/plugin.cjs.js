'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const BluetoothAudio = core.registerPlugin('BluetoothAudio', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.BluetoothAudioWeb()),
});

class BluetoothAudioWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    BluetoothAudioWeb: BluetoothAudioWeb
});

exports.BluetoothAudio = BluetoothAudio;
//# sourceMappingURL=plugin.cjs.js.map
