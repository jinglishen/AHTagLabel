//
//  AHTag.h
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHTag : NSObject

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *sortId;
@property (nonatomic, strong) NSNumber *enabled;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) NSNumber *isCustomer;

+ (NSArray *)testTags;

@end

@interface NSDictionary (Extensions)

- (AHTag *)tag;

@end

@interface NSString (Extensions)

- (UIColor *)color;

@end
