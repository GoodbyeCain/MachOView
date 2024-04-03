/*
 *  AppController.h
 *  MachOView
 *
 *  Created by psaghelyi on 15/06/2010.
 *
 */

#import <Cocoa/Cocoa.h>

@class MVPreferenceController;
@class CompareWindowController;

@interface MVAppController : NSObject <NSApplicationDelegate,NSOpenSavePanelDelegate>
{
  MVPreferenceController * preferenceController;
  CompareWindowController * compareController;
}

- (IBAction)showPreferencePanel:(id)sender;
- (IBAction)attach:(id)sender;

@end




