import { WebPlugin } from '@capacitor/core';

import type { BluetoothAudioPlugin, CheckAudioPlayingResponse, DevicesListResponse } from './definitions';

export class BluetoothAudioWeb
  extends WebPlugin
  implements BluetoothAudioPlugin
{
  async getConnectedDevices(): Promise<DevicesListResponse> {
      return {
        devices: []
      }
  }

  async isAudioPlaying(): Promise<CheckAudioPlayingResponse> {
    return {
      isAudioPlaying: true
    }
  }
}
