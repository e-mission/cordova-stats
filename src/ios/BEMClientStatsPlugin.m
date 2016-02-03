#import "BEMClientStatsPlugin.h"
#import "BEMClientStatsDatabase.h"

@implementation BEMClientStatsPlugin

- (void)storeMeasurement:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    @try {
        NSString* key = [[command arguments] objectAtIndex:0];
        NSString* value = [[command arguments] objectAtIndex:1];
        NSString* ts = [[command arguments] objectAtIndex:2];

        [[ClientStatsDatabase database] storeMeasurement:key value:value ts:ts];
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:callbackId];
    }
    @catch (NSException* e) {
        NSString* msg = [NSString stringWithFormat: @"While storing stat, error %@", e];
        CDVPluginResult* result = [CDVPluginResult
                                   resultWithStatus:CDVCommandStatus_ERROR
                                   messageAsString:msg];
        [self.commandDelegate sendPluginResult:result callbackId:callbackId];
    }
}
@end

