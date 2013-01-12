//
//  APDialog.h
//
//  Created by Apisit Toompakdee on 9/9/12.
//  Copyright (c) 2012 Apisit Toompakdee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickedButtonAtIndex) (NSInteger buttonIndex);
@interface APDialog : UIViewController

+(void)alertInView:(UIView*)view Title:(NSString*)title message:(NSString*)message buttons:(NSArray*)buttons icons:(NSArray*)icons clickedButtonAtIndex:(ClickedButtonAtIndex)clickedButtonAtIndex;


+(void)didTapButton:(id)sender;
@end
