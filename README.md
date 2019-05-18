# DiHola Shaking API for React Native

DiHola Shaking API makes it easy to build fast and reliable ways to communicate between devices, just by shaking them.
We provide such a secure and flexible protocol that this technology can be applied in any form of data exchange: Payment processing, file sharing, social networking, verification processes, etc.

## Index
1. [Installation](#installation)
2. [Usage](#usage)
3. [Methods](#methods)
4. [Error Codes](#error-codes)


Installation
-------

`$ npm install react-native-dihola-shaking --save`

### Mostly automatic installation

`$ react-native link react-native-dihola-shaking`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-dihola-shaking` and add `RNDiHolaShaking.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNDiHolaShaking.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.diholapp.RNDiHolaShakingPackage;` to the imports at the top of the file
  - Add `new RNDiHolaShakingPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-dihola-shaking'
  	project(':react-native-dihola-shaking').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-dihola-shaking/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-dihola-shaking')
  	```
    
    
Usage
-------

```javascript
import { ShakingAPI, ShakingCodes } from 'react-native-dihola-shaking';

ShakingAPI.configure({

    API_KEY: "<API_KEY>",
    user: "<USER_ID>",
    
    onShaking: () => {
      console.log("SHAKEN");
    },
    
    onSuccess: (result) => {
      if(result.length) console.log("You connected with: " + result);
      else console.log("Couldn't find anyone...");
    },
    
    onError: (error) => {
      console.log(error);
    }
    
}).start();
```

Methods
-------

### Summary

* [`configure`](#configure)
* [`start`](#start)
* [`stop`](#stop)
* [`simulate`](#simulate)
* [`setSensibility`](#setsensibility)
* [`setDistanceFilter`](#setdistancefilter)
* [`setTimingFilter`](#settimingfilter)
* [`setKeepSearching`](#setkeepsearching)
* [`setLocation`](#setlocation)



### Details

#### `configure()`

```javascript
ShakingAPI.configure(options);
```
 - **options**:

    | Name | Type | Default | Required | Description |
    | -- | -- | -- | -- | -- |
    | API_KEY | `string` | -- | `yes` | Get one at www.diholapp.com |
    | user | `string` | -- | `yes` |User identifier |
    | sensibility | `double` | `25` | `no` | Shaking sensibility
    | distanceFilter | `double` | `100` | `no` |maximum distance (in meters) between two devices to be eligible for pairing.
    | keepSearching | `bool` | `false` | `no` | A positive value would allow to keep searching even though if a user has been found. This could allow to pair with multiple devices. The response time will be affected by the timingFilter value.
    | onShaking | `function` | -- | `no` | Invoked when the shaking event is triggered
    | onSuccess | `function` | -- | `yes` | Invoked with a list of paired users
    | onError | `function` | -- | `yes` | Invoked whenever an error is encountered


---


#### `start()`

```javascript
ShakingAPI.start();
```

Starts listening to shaking events.


---

#### `stop()`

```javascript
ShakingAPI.stop();
```

Stops listening to shaking events.

---

#### `simulate()`

```javascript
ShakingAPI.simulate();
```

Simulates the shaking event.


---

#### `setSensibility()`

```javascript
ShakingAPI.setSensibility(sensibility);
```

Sets the sensibility for the shaking event to be triggered.

**Parameters:**

| Name        | Type     | Default|
| ----------- | -------- | -------- |
| sensibility| double     | 25      |

---


#### `setDistanceFilter()`

```javascript
ShakingAPI.setDistanceFilter(distanceFilter);
```

Sets the maximum distance (in meters) between two devices to be eligible for pairing.

**Parameters:**

| Name        | Type     | Default| Note|
| ----------- | -------- | -------- | ----------------------------------------- |
| distanceFilter| int     | 100  | GPS margin error must be taken into account        |

---


#### `setTimingFilter()`

```javascript
ShakingAPI.setTimingFilter(timingFilter);
```

Sets the maximum time difference (in milliseconds) between two shaking events to be eligible for pairing.

**Parameters:**

| Name        | Type     | Default| Note|
| ----------- | -------- | -------- | -------- |
| timingFilter| int   | 2000 | Value between 100 and 10000 |

---

#### `setKeepSearching()`

```javascript
ShakingAPI.setKeepSearching(keepSearching);
```

A positive value would allow to keep searching even though if a user has been found. This could allow to pair with multiple devices. The response time will be affected by the timingFilter value.

**Parameters:**

| Name        | Type     | Default|
| ----------- | -------- | -------- |
| keepSearching| boolean| false|

---


#### `setLocation()`


```javascript
ShakingAPI.setLocation(latitude, longitude);
```

Setting the location manually will disable using the device location.

**Parameters:**

| Name        | Type     | Default  |
| ----------- | -------- | -------- |
| latitude    | double   | Device current value|
| longitude   | double   | Device current value|



Error Codes
----------

| Name                     |  Description|
| ---------------------    |  -------- |
| LOCATION_PERMISSION_ERROR| Location permission has not been accepted|
| LOCATION_DISABLED        | Location is disabled|
| SENSOR_ERROR             | The sensor devices are not available |
| AUTHENTICATION_ERROR     | API key invalid|
| API_KEY_EXPIRED          | API key expired|
| SERVER_ERROR             | Server is not available|
  
Example:

```javascript

ShakingAPI.configure({

  ...
      
  onError: (error) => {

    switch(error){
      case ShakingCodes.LOCATION_PERMISSION_ERROR:
        // Do something
        break;
      case ShakingCodes.LOCATION_DISABLED:
        // Do something
        break;
      case ShakingCodes.AUTHENTICATION_ERROR:
        // Do something
        break;
      case ShakingCodes.API_KEY_EXPIRED:
        // Do something
        break;
      case ShakingCodes.SERVER_ERROR:
        // Do something
        break;
      case ShakingCodes.SENSOR_ERROR:
        // Do something
        break;
    }

  }
      
});

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.