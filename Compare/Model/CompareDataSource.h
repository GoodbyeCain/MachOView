//
//  CompareDataSource.h
//  MachOView
//
//  Created by saycain on 2024/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MVDocument;
@interface CompareDataSource : NSObject<NSOutlineViewDataSource>
- (instancetype)initWithDocument:(MVDocument *) document;
@end

NS_ASSUME_NONNULL_END
