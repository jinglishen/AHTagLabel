//
//  AHTagsLabel.h
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHTag.h"

typedef void (^TagLabelSelectedBlock)(NSArray<AHTag *> *chooseTags, AHTag *selectedTag);

@interface AHTagsLabel : UILabel

@property (nonatomic, strong) NSArray<AHTag *> *tags;

@property (nonatomic, copy) TagLabelSelectedBlock tagLabelSelectedBlock;

@end

@interface AHTagsLabel ()

@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalBorderColor;
@property (nonatomic, strong) UIColor *selectedBorderColor;

@property (nonatomic, assign) CGFloat labelCornerRadius;

@property (nonatomic, assign) BOOL canMultiSelect;      //是否允许多选
@property (nonatomic, assign) CGFloat tagMinWidth;      //最小宽度

@end
