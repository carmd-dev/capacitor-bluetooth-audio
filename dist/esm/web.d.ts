import { WebPlugin } from '@capacitor/core';
import type { BluetoothAudioPlugin, DevicesListResponse } from './definitions';
export declare class BluetoothAudioWeb extends WebPlugin implements BluetoothAudioPlugin {
    getConnectedDevices(): Promise<DevicesListResponse>;
}
