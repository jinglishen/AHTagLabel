//
//  AHTagsLabel.m
//  AutomaticHeightTagTableViewCell
//
//  Created by WEI-JEN TU on 2016-07-16.
//  Copyright © 2016 Cold Yam. All rights reserved.
//

#import "AHTagsLabel.h"
#import "AHTagView.h"

@implementation AHTagsLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupGesture];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
    [self setupGesture];
}

- (void)setup {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    self.tagMinWidth = 55;
}

- (void)setupGesture {
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tap:)];
    [self addGestureRecognizer:recognizer];
}

- (UIFont *)labelFont
{
    if (!_labelFont) {
        _labelFont = [UIFont systemFontOfSize:14];
    }
    
    return _labelFont;
}

- (UIColor *)normalColor
{
    if (!_normalColor) {
        return [UIColor lightGrayColor];
    }
    
    return _normalColor;
}

- (UIColor *)selectedColor
{
    if (!_selectedColor) {
        return [UIColor redColor];
    }
    
    return _selectedColor;
}

- (UIColor *)normalBorderColor
{
    if (!_normalBorderColor) {
        return self.normalColor;
    }
    
    return _normalBorderColor;
}

- (UIColor *)selectedBorderColor
{
    if (!_selectedBorderColor) {
        return self.selectedColor;
    }
    
    return _selectedBorderColor;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)tap:(UITapGestureRecognizer *)recognizer {
    UILabel *label = (UILabel *)recognizer.view;
    CGSize labelSize = recognizer.view.bounds.size;
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:labelSize];
    container.lineFragmentPadding = 0.0;
    container.lineBreakMode = label.lineBreakMode;
    container.maximumNumberOfLines = label.numberOfLines;
    
    NSLayoutManager *manager = [NSLayoutManager new];
    [manager addTextContainer:container];
    
    NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:label.attributedText];
    [storage addLayoutManager:manager];
    
    CGPoint touchPoint = [recognizer locationInView:label];
    NSInteger indexOfCharacter = [manager characterIndexForPoint:touchPoint
                                                 inTextContainer:container
                        fractionOfDistanceBetweenInsertionPoints:nil];
    

    //是否是多选
    if (_canMultiSelect) {
        AHTag *currentTag = _tags[indexOfCharacter];
        NSNumber *enabled = currentTag.enabled;
        currentTag.enabled = [NSNumber numberWithBool:!enabled.boolValue];
    } else {
        for (AHTag *tag in _tags) {
            if ([_tags indexOfObject:tag] == indexOfCharacter) {
                tag.enabled = [NSNumber numberWithBool:YES];
            } else {
                tag.enabled = [NSNumber numberWithBool:NO];
            }
        }
    }
    
    if (self.tagLabelSelectedBlock) {
        NSMutableArray *chooseTags = [NSMutableArray new];
        for (AHTag *tag in _tags) {
            if (tag.enabled.boolValue) {
                [chooseTags addObject:tag];
            }
        }
        
        self.tagLabelSelectedBlock(chooseTags, _tags[indexOfCharacter]);
    }
    [self setTags:_tags];
}

#pragma mark - Tags setter

- (void)setTags:(NSArray<AHTag *> *)tags {
    _tags = tags;
    
    UITableViewCell *cell = [UITableViewCell new];
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    NSMutableArray *chooseTags = [NSMutableArray new];
    for (NSInteger i = 0; i < tags.count; i++) {
        AHTag *tag = tags[i];
        NSString *title = tag.title;
        NSNumber *enabled = tag.enabled;
        UIFont *labelFont = self.labelFont;
        UIColor *color = enabled.boolValue == YES ? self.selectedColor : self.normalColor;
        UIColor *borderColor = enabled.boolValue == YES ? self.selectedBorderColor : self.normalBorderColor;

        AHTagView *view = [AHTagView new];
        view.label.attributedText = [AHTagsLabel attributedString:title];
        view.label.font = labelFont;
        view.label.textColor = color;
        view.label.layer.borderColor = borderColor.CGColor;
        if (_labelCornerRadius > 0) {
            view.label.layer.cornerRadius = _labelCornerRadius;
            view.label.layer.masksToBounds = YES;
        } else {
            view.label.layer.cornerRadius = 0;
            view.label.layer.masksToBounds = NO;
        }
        
        CGSize size = [view systemLayoutSizeFittingSize:view.frame.size
                          withHorizontalFittingPriority:UILayoutPriorityFittingSizeLevel
                                verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
        CGFloat viewWidth = size.width < self.tagMinWidth ? self.tagMinWidth : size.width;
        viewWidth += 20;
        view.frame = CGRectMake(0, 0, viewWidth, size.height);
        [cell.contentView addSubview:view];
        
        UIImage *image = view.image;
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        
        NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [mutableString beginEditing];
        [mutableString appendAttributedString:attrStr];
        [mutableString endEditing];
        
        if (enabled.boolValue) {
            [chooseTags addObject:tag];
        }
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5.0;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [mutableString addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, mutableString.length)];
    self.attributedText = mutableString;
}

#pragma mark - NSAttributedString

+ (NSAttributedString *)attributedString:(NSString *)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{
                                 NSFontAttributeName            : [UIFont boldSystemFontOfSize:14.0],
                                 NSParagraphStyleAttributeName  : paragraphStyle
                                 };
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                         attributes:attributes];
    
    return attributedText;
}

@end
