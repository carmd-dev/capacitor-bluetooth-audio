# capacitor-bluetooth-audio

Capacitor Bluetooth Audio

## Install

```bash
npm install capacitor-bluetooth-audio
npx cap sync
```

## API

<docgen-index>

* [`getConnectedDevices()`](#getconnecteddevices)
* [`addListener('connectivity_status', ...)`](#addlistenerconnectivity_status)
* [`removeAllListeners()`](#removealllisteners)
* [`isAudioPlaying()`](#isaudioplaying)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getConnectedDevices()

```typescript
getConnectedDevices() => Promise<DevicesListResponse>
```

**Returns:** <code>Promise&lt;<a href="#deviceslistresponse">DevicesListResponse</a>&gt;</code>

--------------------


### addListener('connectivity_status', ...)

```typescript
addListener(eventName: 'connectivity_status', listenerFunc: (event: ConnectivityStatusEventResponse) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

| Param              | Type                                                                                                            |
| ------------------ | --------------------------------------------------------------------------------------------------------------- |
| **`eventName`**    | <code>'connectivity_status'</code>                                                                              |
| **`listenerFunc`** | <code>(event: <a href="#connectivitystatuseventresponse">ConnectivityStatusEventResponse</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### isAudioPlaying()

```typescript
isAudioPlaying() => Promise<CheckAudioPlayingResponse>
```

**Returns:** <code>Promise&lt;<a href="#checkaudioplayingresponse">CheckAudioPlayingResponse</a>&gt;</code>

--------------------


### Interfaces


#### DevicesListResponse

| Prop          | Type                          |
| ------------- | ----------------------------- |
| **`devices`** | <code>DeviceResponse[]</code> |


#### DeviceResponse

| Prop          | Type                |
| ------------- | ------------------- |
| **`address`** | <code>string</code> |
| **`id`**      | <code>string</code> |
| **`name`**    | <code>string</code> |
| **`class`**   | <code>string</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### ConnectivityStatusEventResponse

| Prop            | Type                                                      |
| --------------- | --------------------------------------------------------- |
| **`device`**    | <code><a href="#deviceresponse">DeviceResponse</a></code> |
| **`connected`** | <code><a href="#boolean">Boolean</a></code>               |


#### Boolean

| Method      | Signature        | Description                                          |
| ----------- | ---------------- | ---------------------------------------------------- |
| **valueOf** | () =&gt; boolean | Returns the primitive value of the specified object. |


#### CheckAudioPlayingResponse

| Prop                 | Type                 |
| -------------------- | -------------------- |
| **`isAudioPlaying`** | <code>boolean</code> |

</docgen-api>
