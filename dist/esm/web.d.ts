import { PluginListenerHandle, WebPlugin } from '@capacitor/core';
import type { BluetoothAudioPlugin, CheckAudioPlayingResponse, ConnectivityStatusEventResponse, DevicesListResponse } from './definitions';
export declare class BluetoothAudioWeb extends WebPlugin implements BluetoothAudioPlugin {
    getConnectedDevices(): Promise<DevicesListResponse>;
    addListener(eventName: 'connectivity_status', listenerFunc: (event: ConnectivityStatusEventResponse) => void): Promise<PluginListenerHandle> & PluginListenerHandle;
    removeAllListeners(): Promise<void>;
    isAudioPlaying(): Promise<CheckAudioPlayingResponse>;
}
