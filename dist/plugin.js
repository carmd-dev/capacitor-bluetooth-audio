var capacitorBluetoothAudio = (function (exports, core) {
    'use strict';

    const BluetoothAudio = core.registerPlugin('BluetoothAudio', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.BluetoothAudioWeb()),
    });

    class BluetoothAudioWeb extends core.WebPlugin {
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

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        BluetoothAudioWeb: BluetoothAudioWeb
    });

    exports.BluetoothAudio = BluetoothAudio;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
