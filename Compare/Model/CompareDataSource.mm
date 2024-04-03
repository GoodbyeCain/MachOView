//
//  CompareDataSource.m
//  MachOView
//
//  Created by saycain on 2024/4/3.
//

#import "CompareDataSource.h"
#import "DataController.h"
#import "Document.h"

@interface CompareDataSource ()
@property (nonatomic, weak) MVDocument *document;
@end

//============================================================================
@implementation CompareDataSource

- (instancetype)initWithDocument:(MVDocument *) document {
    self = [super init];
    if(self) {
        self.document = document;
    }
    return  self;
}

#pragma mark NSOutlineView must-have delegates

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
  if (item == nil)
  {
    return 1;
  }
  
  MVNode * node = item;
  return node.numberOfChildren;
}
//----------------------------------------------------------------------------

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
  if (item == nil)
  {
    return YES;
  }
  
  MVNode * node = item;
  return (node.numberOfChildren > 0);
}
//----------------------------------------------------------------------------

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
  MVDocument * document = self.document;
  if (item == nil)
  {
    return document.dataController.rootNode;
  }
  
  MVNode * node = item;
  return [node childAtIndex:index];
}
//----------------------------------------------------------------------------

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
  if (item == nil)
  {
    return @"-";
  }
  
  MVNode * node = item;
  
  if (node.details != nil && node.detailsOffset == 0)
  {
    return [@"*" stringByAppendingString:node.caption];
  }
  
  if(node.similarInfo != nil) {
      return [NSString stringWithFormat:@"%@ %@", node.caption, node.similarInfo];
  }
  return node.caption;
}
//----------------------------------------------------------------------------

@end
