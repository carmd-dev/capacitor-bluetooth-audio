import { WebPlugin } from '@capacitor/core';
import type { BluetoothAudioPlugin, CheckAudioPlayingResponse, DevicesListResponse } from './definitions';
export declare class BluetoothAudioWeb extends WebPlugin implements BluetoothAudioPlugin {
    getConnectedDevices(): Promise<DevicesListResponse>;
    isAudioPlaying(): Promise<CheckAudioPlayingResponse>;
}
