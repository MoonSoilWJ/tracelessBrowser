//
//  UILabel+ContentSize.h
//  
//
//  Created by mac  on 14-2-13.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ShortCut)



/**
 *  调整以适应
 *
 *  @return
 */
-(float)resizeToFit:(float)with;



/**
 *  预期的高度
 *
 *  @return
 */
-(float)expectedHeight:(float)with;




/**
 *  计算UIlabel的内容的大小
 *
 *  @return 
 */
-(CGSize)contentSize;
@end
