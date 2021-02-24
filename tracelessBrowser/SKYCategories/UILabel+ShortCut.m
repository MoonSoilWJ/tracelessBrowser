//
//  UILabel+ContentSize.m
//  开吃
//
//  Created by mac  on 14-2-13.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "UILabel+ShortCut.h"

@implementation UILabel (ShortCut)

///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(float)resizeToFit:(float)with
{
    float height = [self expectedHeight:with];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
-(float)expectedHeight:(float)with
{
//    [self setNumberOfLines:0];
//    [self setLineBreakMode:NSLineBreakByWordWrapping];
//    
//    CGSize maximumLabelSize = CGSizeMake(with,9999);
//    
//    CGSize expectedLabelSize = [[self text] sizeWithFont:[self font]
//                                       constrainedToSize:maximumLabelSize
//                                           lineBreakMode:[self lineBreakMode]];
    return 0;
}


///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
- (CGSize)contentSize
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}
@end
