#import "SelectPanel.h"

@implementation SelectPanel

RCT_EXPORT_MODULE()

// Example method
// See // https://facebook.github.io/react-native/docs/native-modules-ios
RCT_REMAP_METHOD(open,
                 openPanelWithOptions:(nonnull NSDictionary*)options
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
	dispatch_sync(dispatch_get_main_queue(), ^{
		[self openPanelWithOptions:options];
	});

  //resolve(result);
}

-(void)openPanelWithOptions: (NSDictionary*) options{
	if(!panel){
		panel = [NSOpenPanel openPanel];
	}
	
	for (id key in options)
	{
		SEL selector = NSSelectorFromString(key);
		if ([panel respondsToSelector:selector]) {
			id value = options[key];
			NSLog(@"%@ %@", key, value);
			
			[panel setValue:value forKey:key];
		}
	}

	[panel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
		if (result == NSModalResponseOK) {
			for (NSURL *url in [panel URLs]) {
				NSLog(@"--->%@",url);
			}
		}
	}];
}

@end
