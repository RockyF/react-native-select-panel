#import "SelectPanel.h"

@implementation SelectPanel

NSOpenPanel *openPanel;
NSSavePanel *savePanel;

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(open,
                 openPanelWithOptions:(nonnull NSDictionary*)options
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
	dispatch_sync(dispatch_get_main_queue(), ^{
		[self openPanelWithOptions:options withCallback:^(NSArray *files) {
			if(files == nil){
				NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey:@"operate canceld"}];
				reject(@"canceld", @"operate canceld", error);
			}else{
				resolve(files);
			}
		}];
	});
}

RCT_REMAP_METHOD(save,
                 savePanelWithOptions:(nonnull NSDictionary*)options
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)
{
	dispatch_sync(dispatch_get_main_queue(), ^{
		[self savePanelWithOptions:options withCallback:^(NSString *file) {
			if(file == nil){
				NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey:@"operate canceld"}];
				reject(@"canceld", @"operate canceld", error);
			}else{
				resolve(file);
			}
		}];
	});
}

-(void)openPanelWithOptions: (NSDictionary*) options withCallback: (void (^)(NSArray* files)) block{
	if(!openPanel){
		openPanel = [NSOpenPanel openPanel];
	}
	
	for (id key in options)
	{
		SEL selector = NSSelectorFromString(key);
		if ([openPanel respondsToSelector:selector]) {
			id value = options[key];
			NSLog(@"%@ %@", key, value);
			
			[openPanel setValue:value forKey:key];
		}
	}
	
	[openPanel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
		if (result == NSModalResponseOK) {
			NSArray *files = [[NSArray alloc]init];
			for (NSURL *url in [openPanel URLs]) {
				NSLog(@"--->%@",url);
				files = [files arrayByAddingObject:url.path];
			}
			block(files);
		}else if (result == NSModalResponseCancel) {
			block(nil);
		}
	}];
}

-(void)savePanelWithOptions: (NSDictionary*) options withCallback: (void (^)(NSString *file)) block{
	if(!savePanel){
		savePanel = [NSOpenPanel openPanel];
		[savePanel setCanCreateDirectories:NO];
	}
	
	for (id key in options)
	{
		SEL selector = NSSelectorFromString(key);
		if ([savePanel respondsToSelector:selector]) {
			id value = options[key];
			NSLog(@"%@ %@", key, value);
			
			[savePanel setValue:value forKey:key];
		}
	}
	
	[savePanel beginSheetModalForWindow:[NSApp mainWindow] completionHandler:^(NSModalResponse result) {
		if (result == NSModalResponseOK) {
			block([savePanel URL].path);
		}else if (result == NSModalResponseCancel) {
			block(nil);
		}
	}];
}

@end
