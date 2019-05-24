
/**
* Original work: Copyright (c) 2017 Daniel Schmidt
* Modified work: Copyright (c) 2019 DiHola S.L.
*
* This source code is licensed under the Apache 2.0 license found in 
* https://github.com/diholapp/react-native-dihola-shaking/blob/master/LICENSE.
*
*/

#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import "RNDiholaShaking.h"

@implementation Accelerometer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"Accelerometer");

    if (self) {
        self->_motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_REMAP_METHOD(isAvailable,
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
    return [self isAvailableWithResolver:resolve
                                rejecter:reject];
}

- (void) isAvailableWithResolver:(RCTPromiseResolveBlock) resolve
                        rejecter:(RCTPromiseRejectBlock) reject {
    if([self->_motionManager isAccelerometerAvailable])
    {
        /* Start the accelerometer if it is not active already */
        if([self->_motionManager isAccelerometerActive] == NO)
        {
            resolve(@YES);
        } else {
            reject(@"-1", @"Accelerometer is not active", nil);
        }
    }
    else
    {
        reject(@"-1", @"Accelerometer is not available", nil);
    }
}

RCT_EXPORT_METHOD(setUpdateInterval:(double) interval) {
    NSLog(@"setUpdateInterval: %f", interval);
    double intervalInSeconds = interval / 1000;

    [self->_motionManager setAccelerometerUpdateInterval:intervalInSeconds];
}

RCT_EXPORT_METHOD(getUpdateInterval:(RCTResponseSenderBlock) cb) {
    double interval = self->_motionManager.accelerometerUpdateInterval;
    NSLog(@"getUpdateInterval: %f", interval);
    cb(@[[NSNull null], [NSNumber numberWithDouble:interval]]);
}

RCT_EXPORT_METHOD(getData:(RCTResponseSenderBlock) cb) {
    double x = self->_motionManager.accelerometerData.acceleration.x;
    double y = self->_motionManager.accelerometerData.acceleration.y;
    double z = self->_motionManager.accelerometerData.acceleration.z;
    double timestamp = self->_motionManager.accelerometerData.timestamp;

    NSLog(@"getData: %f, %f, %f, %f", x, y, z, timestamp);

    cb(@[[NSNull null], @{
                 @"x" : [NSNumber numberWithDouble:x],
                 @"y" : [NSNumber numberWithDouble:y],
                 @"z" : [NSNumber numberWithDouble:z],
                 @"timestamp" : [NSNumber numberWithDouble:timestamp]
             }]
       );
}

RCT_EXPORT_METHOD(startUpdates) {
    NSLog(@"startUpdates");
    [self->_motionManager startAccelerometerUpdates];

    /* Receive the accelerometer data on this block */
    [self->_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                               withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         double x = accelerometerData.acceleration.x;
         double y = accelerometerData.acceleration.y;
         double z = accelerometerData.acceleration.z;
         double timestamp = accelerometerData.timestamp;
         NSLog(@"startAccelerometerUpdates: %f, %f, %f, %f", x, y, z, timestamp);

         [self.bridge.eventDispatcher sendDeviceEventWithName:@"Accelerometer" body:@{
                                                                                   @"x" : [NSNumber numberWithDouble:x],
                                                                                   @"y" : [NSNumber numberWithDouble:y],
                                                                                   @"z" : [NSNumber numberWithDouble:z],
                                                                                   @"timestamp" : [NSNumber numberWithDouble:timestamp]
                                                                               }];
     }];

}

RCT_EXPORT_METHOD(stopUpdates) {
    NSLog(@"stopUpdates");
    [self->_motionManager stopAccelerometerUpdates];
}

@end
