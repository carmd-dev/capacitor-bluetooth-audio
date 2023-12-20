package com.carmd.capacitor.bluetooth.audio

import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.util.Log
import com.getcapacitor.JSArray
import com.getcapacitor.JSObject
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin

@CapacitorPlugin(name = "BluetoothAudio")
@SuppressLint("MissingPermission")
class BluetoothAudioPlugin : Plugin() {

    companion object {
        private const val EVENT_CONNECTIVITY_STATUS = "connectivity_status"
    }

    private lateinit var bluetoothService: BluetoothAudioService
    private val broadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            intent?.getParcelableExtra<BluetoothDevice>(BluetoothDevice.EXTRA_DEVICE)?.let {
                when (intent?.action) {
                    BluetoothDevice.ACTION_ACL_CONNECTED -> {
                        notifyConnectivityStatus(it, true)
                    }
                    BluetoothDevice.ACTION_ACL_DISCONNECTED -> {
                        notifyConnectivityStatus(it, false)
                    }
                }
            }
        }
    }

    override fun load() {
        super.load()
        bluetoothService = BluetoothAudioService(context)

        val intentFilter = IntentFilter()
        intentFilter.addAction(BluetoothDevice.ACTION_ACL_CONNECTED)
        intentFilter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED)
        activity.registerReceiver(broadcastReceiver, intentFilter)
    }

    override fun handleOnDestroy() {
        super.handleOnDestroy()
        activity.unregisterReceiver(broadcastReceiver)
    }

    @PluginMethod
    fun getConnectedDevices(call: PluginCall) {
        bluetoothService.getConnectedDevices(context) {
            val devicesList = JSArray()
            it.forEach { device -> devicesList.put(deviceToJSObject(device)) }
            val response = JSObject()
            response.put("devices", devicesList)
            call.resolve(response)
        }
    }

    private fun notifyConnectivityStatus(device: BluetoothDevice, connected: Boolean) {
        val obj = JSObject()
        obj.put("device", deviceToJSObject(device))
        obj.put("connected", connected)
        notifyListeners(EVENT_CONNECTIVITY_STATUS, obj)
    }

    private fun deviceToJSObject(device: BluetoothDevice): JSObject {
        val obj = JSObject()
        obj.put("name", device.name)
        obj.put("address", device.address)
        obj.put("id", device.address)
        device.bluetoothClass?.let {
            obj.put("class", it.deviceClass)
        }
        return obj
    }
}
