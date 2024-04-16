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
#import "MVNode+Compare.h"
#import "CompareModel.h"

@interface CompareWindowController ()
@property (nonatomic, strong) CompareDataSource *leftDataSource;
@property (nonatomic, strong) CompareDataSource *rightDataSource;
@property (nonatomic, strong) NSThread *compareThread;

@property (nonatomic, strong) IBOutlet NSOutlineView *  leftView ;
@property (nonatomic, strong) IBOutlet NSOutlineView *  rightView;
@end

@implementation CompareWindowController

- (instancetype)init 
{
    self = [super initWithWindowNibName:@"CompareWindowController"];
    self.compareThread = [[NSThread alloc] initWithTarget:self selector:@selector(doCompare) object:nil];
    return self;
}

- (void)windowDidLoad 
{
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

- (void)doCompare 
{
    NSArray <MVNode *>* leftNodes = [_leftDocument.dataController.rootNode currChildren];
    NSArray <MVNode *>* rightNodes = [_rightDocument.dataController.rootNode currChildren];
    NSMutableArray <CompareModel *>*resultList = [NSMutableArray array];
    
    for (NSUInteger lIndex = 0; lIndex < leftNodes.count; lIndex ++) 
    {
        MVNode *leftNode = leftNodes[lIndex];
        for(NSUInteger rIndex = 0; rIndex < rightNodes.count; rIndex ++) 
        {
            MVNode *rightNode = rightNodes[rIndex];
            if([leftNode.caption isEqualToString:rightNode.caption]) {
                CompareModel *result = [leftNode compareWithNode:rightNode];
                if(result.compared) 
                {
                    [resultList addObject:result];
                }

                break;
            }
        }
        
        NSLog(@"Compare percent: %f", (float)(lIndex + 1) / leftNodes.count);
    }
    
    NSLog(@"Summary compare result");
    NSLog(@"Left file URL =>%@", _leftDocument.fileURL.absoluteURL);
    NSLog(@"Right file URL =>%@", _rightDocument.fileURL.absoluteURL);
    for (CompareModel *result in resultList) {
        NSLog(@"\t%@", result);
    }
    
    
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [weakSelf.leftView reloadData];
    });
}

@end
