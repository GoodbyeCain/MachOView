//
//  MachOLayout+Compare.h
//  MachOView
//
//  Created by saycain on 2024/4/16.
//

#import "MachOLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface MachOLayout (Compare)
- (void)compareWithLayout:(MachOLayout *) other;
@end

NS_ASSUME_NONNULL_END
