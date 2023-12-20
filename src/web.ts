import { WebPlugin } from '@capacitor/core';

import type { BluetoothAudioPlugin, DevicesListResponse } from './definitions';

export class BluetoothAudioWeb
  extends WebPlugin
  implements BluetoothAudioPlugin
{
  async getConnectedDevices(): Promise<DevicesListResponse> {
      return {
        devices: []
      }
  }
}
