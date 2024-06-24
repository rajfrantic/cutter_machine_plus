package com.cuttermachineplus.cutter_machine_plus;

import static android.Manifest.permission.ACCESS_FINE_LOCATION;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import pub.devrel.easypermissions.EasyPermissions;

import com.inuker.bluetooth.library.cc.BluetoothSDK;
import com.inuker.bluetooth.library.cc.MachineEnum;
import com.inuker.bluetooth.library.cc.listener.IBluetoothConnectListener;
import com.inuker.bluetooth.library.cc.listener.IBluetoothSearchListener;
import com.inuker.bluetooth.library.cc.IBleDefaultResultCallBack;

import com.inuker.bluetooth.library.search.SearchResult;

import org.json.JSONObject;

import java.lang.reflect.Array;
import java.util.ArrayList;


/** CutterMachinePlugin */
public class CutterMachinePlusPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context mContext;
  private Activity activity;


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "cutter_machine_plus");
    channel.setMethodCallHandler(this);
    BluetoothSDK.init(flutterPluginBinding.getApplicationContext(),"pwd", MachineEnum.MachineType_Cut);
    mContext = flutterPluginBinding.getApplicationContext();

  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    if (call.method.equals("searchBluetooth")) {
      Log.d("Data Add Cutter", "Hello: ");
      if ( !(ContextCompat.checkSelfPermission(mContext, ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED) ) {
         Log.d("Data Add Cutter", "Hello: if");
        ActivityCompat.requestPermissions(this.activity, new String[]{ACCESS_FINE_LOCATION,Manifest.permission.BLUETOOTH_CONNECT,Manifest.permission.BLUETOOTH_SCAN}, 1);
      }else {
 Log.d("Data Add Cutter", "Hello: else");
        BluetoothSDK.init(mContext,"pwd", MachineEnum.MachineType_Cut);



        BluetoothSDK.getInstance().search(10000, new IBluetoothSearchListener() {
          @Override
          public void onDeviceFounded(SearchResult searchResult) {
            Log.d("Data Add Cutter", "onDeviceFounded: "+searchResult.getName());
//            adapter.addData(searchResult);

            result.success("{name:"+searchResult.getName()+",address:"+searchResult.getAddress()+"}");
//            BluetoothSDK.getInstance().connect(searchResult.getAddress(), new IBluetoothConnectListener() {
//              @Override
//              public void onConnected(String s, String s1) {
//
//              }
//
//              @Override
//              public void onError(int i, String s) {
//
//              }
//            });
          }

          @Override
          public void onComplete() {
Log.d("Data Add Cutter", "Hello: Completed");
          }

          @Override
          public void onError(int i, String s) {
Log.d("Data Add Cutter", "Hello: No Device");
          }
        });
      }
    }else if(call.method.equals("connectBluetooth")){
      Log.d("Data Add Cutter", "connectBluetooth: "+call.arguments.toString());

      BluetoothSDK.getInstance().connect(call.arguments.toString(), new IBluetoothConnectListener() {
        @Override
        public void onConnected(String s, String s1) {
          result.success("connected");
        }

        @Override
        public void onError(int i, String s) {
          result.success("failed");

        }
      });
    }else if(call.method.equals("cutFileBluetooth")){
      String fileName = "苹果6前膜.blt";
      BluetoothSDK.getInstance().cutFile(call.arguments.toString(), fileName);
      result.success("connected");
    }else if (call.method.equals("setSpeed")) {
      BluetoothSDK.getInstance().setMachineSpeed(Integer.parseInt(call.arguments.toString()), new IBleDefaultResultCallBack() {
        @Override
        public void onSuccessful() {
          result.success("Set Successfully");
        }

        @Override
        public void onError(int i, String s) {
          result.success("Failed");

        }
      });

    }else if (call.method.equals("setPressure")) {

      BluetoothSDK.getInstance().setMachinePressure(Integer.parseInt(call.arguments.toString()), new IBleDefaultResultCallBack() {
        @Override
        public void onSuccessful() {
          result.success("Set Successfully");
        }

        @Override
        public void onError(int i, String s) {
          result.success("Failed");

        }
      });

    }else if (call.method.equals("cutFileWithHeightAndWidthBluetooth")) {
      String fileName = "苹果6前膜.blt";
      Log.d("Raj data ", "onMethodCall: " +call.arguments.toString());
      int xoffset = Integer.parseInt(call.argument("xoffset").toString());
      int yoffset = Integer.parseInt(call.argument("yoffset").toString());
      int width = Integer.parseInt(call.argument("width").toString());
      int height = Integer.parseInt(call.argument("height").toString());
      Boolean xflip = Boolean.parseBoolean(call.argument("xflip").toString());
      Boolean yflip = Boolean.parseBoolean(call.argument("yflip").toString());
      int ang = Integer.parseInt(call.argument("ang").toString());
      Boolean section = Boolean.parseBoolean(call.argument("section").toString());
      BluetoothSDK.getInstance().cutFile(call.argument("file").toString(), fileName, xoffset,yoffset ,width, height,xflip, yflip,ang,section);

      result.success("Success");
    }else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    // TODO: the Activity your plugin was attached to was destroyed to change configuration.
    // This call will be followed by onReattachedToActivityForConfigChanges().
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
    // TODO: your plugin is now attached to a new Activity after a configuration change.
  }

  @Override
  public void onDetachedFromActivity() {
    // TODO: your plugin is no longer associated with an Activity. Clean up references.
  }

}


