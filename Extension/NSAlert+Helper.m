//
//  NSAlert+Helper.m
//  MachOView
//
//  Created by saycain on 2024/4/3.
//

#import "NSAlert+Helper.h"

@implementation NSAlert(Helper)
+ (void)runModalWithMessage:(NSString *) message {
    NSAlert *attachfail = [[NSAlert alloc] init];
    attachfail.messageText = message;
    [attachfail addButtonWithTitle:@"Ok"];
    [attachfail runModal];
}
@end
