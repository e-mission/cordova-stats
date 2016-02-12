#import "BEMClientStatsPlugin.h"
#import "BEMClientStatsDatabase.h"

@implementation BEMClientStatsPlugin

- (void)pluginInitialize
{
    // TODO: We should consider adding a create statement to the init, similar
    // to android - then it doesn't matter if the pre-populated database is not
    // copied over.
    NSLog(@"BEMClientStatsPlugin pluginInitialize singleton -> initialize native DB");
    [[ClientStatsDatabase database] storeEventNow:@"app_launched"];
}

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

- (void)storeEventNow:(CDVInvokedUrlCommand*)command
{
    NSString* callbackId = [command callbackId];
    @try {
        NSString* key = [[command arguments] objectAtIndex:0];

        [[ClientStatsDatabase database] storeEventNow:key];
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

