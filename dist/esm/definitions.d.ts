import type { PluginListenerHandle } from '@capacitor/core';
export interface BluetoothAudioPlugin {
    getConnectedDevices(): Promise<DevicesListResponse>;
    addListener(eventName: 'connectivity_status', listenerFunc: (event: ConnectivityStatusEventResponse) => void): Promise<PluginListenerHandle> & PluginListenerHandle;
    removeAllListeners(): Promise<void>;
}
export interface DevicesListResponse {
    devices: DeviceResponse[];
}
export interface DeviceResponse {
    address: string;
    id: string;
    name: string;
    class: string;
}
export interface ConnectivityStatusEventResponse {
    device: DeviceResponse;
    connected: Boolean;
}
