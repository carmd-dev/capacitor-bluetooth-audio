import { PluginListenerHandle, WebPlugin } from '@capacitor/core';

import type {
  BluetoothAudioPlugin,
  CheckAudioPlayingResponse,
  ConnectivityStatusEventResponse,
  DevicesListResponse,
} from './definitions';

export class BluetoothAudioWeb
  extends WebPlugin
  implements BluetoothAudioPlugin
{
  async getConnectedDevices(): Promise<DevicesListResponse> {
    return {
      devices: [],
    };
  }

  addListener(
    eventName: 'connectivity_status',
    listenerFunc: (event: ConnectivityStatusEventResponse) => void,
  ): Promise<PluginListenerHandle> & PluginListenerHandle {
    console.log('removeAllListeners');
    throw this.unimplemented('Not implemented on web.' + eventName + listenerFunc);
  }

  removeAllListeners(): Promise<void> {
    console.log('removeAllListeners');
    throw this.unimplemented('Not implemented on web.');
  }
  async isAudioPlaying(): Promise<CheckAudioPlayingResponse> {
    return {
      isAudioPlaying: true,
    };
  }
}
