//
//  CompareWindowController.m
//  MachOView
//
//  Created by saycain on 2024/4/3.
//

#import "CompareWindowController.h"
#import "Document.h"
#import "CompareDataSource.h"
#import "DataController.h"

@interface CompareWindowController ()
@property (nonatomic, strong) CompareDataSource *leftDataSource;
@property (nonatomic, strong) CompareDataSource *rightDataSource;
@property (nonatomic, strong) NSThread *compareThread;

@property (nonatomic, strong) IBOutlet NSOutlineView *  leftView ;
@property (nonatomic, strong) IBOutlet NSOutlineView *  rightView;
@end

@implementation CompareWindowController

- (instancetype)init {
    self = [super initWithWindowNibName:@"CompareWindowController"];
    self.compareThread = [[NSThread alloc] initWithTarget:self selector:@selector(doCompare) object:nil];
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    self.leftDataSource = [[CompareDataSource alloc] initWithDocument:_leftDocument];
    self.rightDataSource = [[CompareDataSource alloc] initWithDocument:_rightDocument];
    
    _leftView.dataSource = _leftDataSource;
    _rightView.dataSource = _rightDataSource;
    
    [_leftView reloadData];
    [_leftView expandItem:_leftDocument.dataController.rootNode];
    [_rightView reloadData];
    [_rightView expandItem:_rightDocument.dataController.rootNode];
    

    [_compareThread start];
}

- (void)doCompare {
    NSArray <MVNode *>* leftNodes = [_leftDocument.dataController.rootNode currChildren];
    NSArray <MVNode *>* rightNodes = [_leftDocument.dataController.rootNode currChildren];
    
    for (NSUInteger lIndex = 0; lIndex < leftNodes.count; lIndex ++) {
        MVNode *leftNode = leftNodes[lIndex];
        for(NSUInteger rIndex = 0; rIndex < rightNodes.count; rIndex ++) {
            MVNode *rightNode = leftNodes[rIndex];
            if([leftNode.caption isEqualToString:rightNode.caption]) {
                [leftNode openDetails];
                [rightNode openDetails];
                
                float similar = [leftNode compareWithNode:rightNode];
                leftNode.similar = similar;
                leftNode.similarInfo = [NSString stringWithFormat:@"%.1f", similar];
                break;
            }
        }
        
        NSLog(@"Compare percent: %f", (float)(lIndex + 1) / leftNodes.count);
    }
    
//    for (NSUInteger i = 0; i < leftNodes.count; i ++) {
//        MVNode *leftNode = leftNodes[i];
//        NSMutableArray <MVNode *>*matchedNodes = [NSMutableArray arrayWithCapacity:2];
//        for (MVNode *rightNode in rightNodes) {
//            if([leftNode.caption isEqualToString:rightNode.caption]) {
//                [matchedNodes addObject:rightNode];
//            }
//        }
//        
//        if(matchedNodes.count == 1) {
//            MVNode *matchedRight = matchedNodes.firstObject;
//            [leftNode openDetails];
//            [matchedRight openDetails];
//            float similar = [leftNode.details compareWithTable:matchedNodes.firstObject.details];
//            leftNode.similar = similar;
//            leftNode.similarInfo = [NSString stringWithFormat:@"%.1f", similar];
//        } else {
//            leftNode.similar = 0;
//            leftNode.similarInfo = @"Node caption more than one";
//        }
//        
//        NSLog(@"Compare percent: %f", (float)(i + 1) / leftNodes.count);
//    }
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [weakSelf.leftView reloadData];
    });
}

@end
