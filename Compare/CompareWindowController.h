//
//  CompareWindowController.h
//  MachOView
//
//  Created by saycain on 2024/4/3.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class MVDocument;
@interface CompareWindowController : NSWindowController
@property (nonatomic, strong) MVDocument *leftDocument;
@property (nonatomic, strong) MVDocument *rightDocument;
@end

NS_ASSUME_NONNULL_END
