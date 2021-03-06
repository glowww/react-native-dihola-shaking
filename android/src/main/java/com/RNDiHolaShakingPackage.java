/**
* Copyright (c) 2019 DiHola S.L.
*
* This source code is licensed under the Apache 2.0 license found in 
* https://github.com/diholapp/react-native-dihola-shaking/blob/master/LICENSE.
*
*/

package com.diholapp;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.facebook.react.bridge.JavaScriptModule;

import com.diholapp.RNFusedLocation.RNFusedLocationModule;

public class RNDiHolaShakingPackage implements ReactPackage {
    @Override
    public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
      return Arrays.<NativeModule>asList(new Accelerometer(reactContext), new RNFusedLocationModule(reactContext));
    }

    // Deprecated from RN 0.47
    public List<Class<? extends JavaScriptModule>> createJSModules() {
      return Collections.emptyList();
    }

    @Override
    public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
      return Collections.emptyList();
    }
}