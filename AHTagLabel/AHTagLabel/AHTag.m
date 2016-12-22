//
//  AHTag.m
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import "AHTag.h"

#define SORTID_KEY @"SORTID"
#define CATEGORYID_KEY @"CATEGORYID"
#define CATEGORY_KEY @"CATEGORY"
#define TITLE_KEY @"TITLE"
#define ENABLED_KEY @"ENABLED"
#define DATA_KEY @"DATA"
#define CUSTOMER_KEY @"CUSTOMER"

@implementation AHTag

@end

@implementation NSDictionary (Extensions)

- (AHTag *)tag {
    
    AHTag *tag = [AHTag new];
    tag.sortId = self[SORTID_KEY];
    tag.categoryId = self[CATEGORYID_KEY];
    tag.category = self[CATEGORY_KEY];
    tag.title = self[TITLE_KEY];
    tag.enabled = self[ENABLED_KEY];
    tag.data = self[DATA_KEY];
    tag.isCustomer = self[CUSTOMER_KEY];
    
    return tag;
}

@end

@implementation NSString (Extensions)

- (UIColor *)color {
    unsigned value = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexInt:&value];
    
    return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
                           green:((float)((value & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((value & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}

@end
