//
//  MVTable+Compare.h
//  MachOView
//
//  Created by saycain on 2024/4/15.
//

#import "DataController.h"
#import "CompareModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVTable (Compare)

- (void)compareStringLiterals:(MVTable *) otherTable resultModel:(CompareModel *) model;

@end

NS_ASSUME_NONNULL_END
