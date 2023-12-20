package com.carmd.capacitor.bluetooth.audio

import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothManager
import android.bluetooth.BluetoothProfile
import android.content.Context
import android.util.Log

@SuppressLint("MissingPermission")
class BluetoothAudioService(context: Context) {
    private val bluetoothAdapter: BluetoothAdapter

    init {
        val btManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
        bluetoothAdapter = btManager.adapter
    }

    fun getConnectedDevices(context: Context, resultCallback: (List<BluetoothDevice>) -> Unit) {
        val profileListener = object : BluetoothProfile.ServiceListener {
            override fun onServiceConnected(profile: Int, proxy: BluetoothProfile?) {
                val connectionState = bluetoothAdapter.getProfileConnectionState(profile)
                if (connectionState == BluetoothProfile.STATE_CONNECTED) {
                    resultCallback.invoke(proxy?.connectedDevices.orEmpty())
                } else {
                    resultCallback.invoke(emptyList())
                }
            }

            override fun onServiceDisconnected(profile: Int) {
                Log.i("ServiceDisconnected", profile.toString())
            }
        }

        bluetoothAdapter.getProfileProxy(context, profileListener, BluetoothProfile.HEADSET)
    }
}
