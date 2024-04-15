//
//  MVNode+Compare.h
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import "DataController.h"
#import "CompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MVTable;
@interface MVNode (Compare)

- (MVTable * )getDetails;

- (CompareModel *)compareWithNode:(MVNode *) other;

- (void)updateSimilar:(float) similar;

@end

NS_ASSUME_NONNULL_END
