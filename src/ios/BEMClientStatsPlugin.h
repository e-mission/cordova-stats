#import <Cordova/CDV.h>

@interface BEMClientStatsPlugin: CDVPlugin
- (void) storeMeasurement:(CDVInvokedUrlCommand*)command;
@end
