//
//  APDialog.m
//
//  Created by Apisit Toompakdee on 9/9/12.
//  Copyright (c) 2012 Apisit Toompakdee. All rights reserved.
//

#import "APDialog.h"

@interface APDialog ()

@end

@implementation APDialog
static ClickedButtonAtIndex _clickedButtonAtIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - did tap button
+(void)didTapButton:(id)sender{
    UIButton* btn = sender;
    NSLog(@"%@",  btn.superview);
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationCurveEaseOut animations:^{
        btn.superview.alpha=0;
    } completion:^(BOOL finished) {
           _clickedButtonAtIndex(btn.tag);
        [btn.superview removeFromSuperview]; 
      
    }];
   
}

#pragma mark - Dialog
+(void)alertInView:(UIView*)view Title:(NSString*)title message:(NSString*)message buttons:(NSArray*)buttons icons:(NSArray*)icons clickedButtonAtIndex:(ClickedButtonAtIndex)clickedButtonAtIndex{
    
    _clickedButtonAtIndex= [clickedButtonAtIndex copy];
    
    UIColor* backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    UIColor* fontcolor =[UIColor whiteColor];
    UIColor* shadowColor =[UIColor blackColor];
    
    
    CGPoint center= view.center;
    UIView* dialogView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 196, 90)];
    dialogView.center=center;
    
    
    UIView* messageView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, dialogView.frame.size.width, 44)];
    [messageView setBackgroundColor:backgroundColor];
    
    //we don't show this rectangle if we don't have title.
    if (title.length>0)
        [dialogView addSubview:messageView];
    
    
    UIFont* labelFont= [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    UILabel* lblTitle=[[UILabel alloc]initWithFrame:messageView.frame];
    [lblTitle setFont:labelFont];
    lblTitle.text=title;
    lblTitle.textColor=fontcolor;
    lblTitle.frame=CGRectMake(0, 0, messageView.frame.size.width,  messageView.frame.size.height);
    lblTitle.backgroundColor=[UIColor clearColor];
    [lblTitle setTextAlignment:UITextAlignmentCenter];
    lblTitle.shadowOffset=CGSizeMake(0, 1);
    lblTitle.shadowColor=shadowColor;
    
    [messageView addSubview:lblTitle];
    
    
    CGFloat buttonWidth =(messageView.frame.size.width/buttons.count);
    for(int i=0;i<buttons.count;i++){
        NSString* buttonTitle= [buttons objectAtIndex:i];
       
        UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake((buttonWidth +1)*i,  10, buttonWidth -(1*i), 44)];
        
        [button.titleLabel setFont:labelFont];
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
      

        button.tag=i;
     
        [button setBackgroundColor:backgroundColor];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:fontcolor  forState:UIControlStateNormal];
        [button setTitleShadowColor:shadowColor forState:UIControlStateNormal];
        
        if (icons!=nil && i<icons.count){
            UIImage* icon= [icons objectAtIndex:i];
            [button setImage:icon forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, buttonTitle.length>0?-10:0, 0, 0)];
        }
        
        [dialogView addSubview:button];
    }
    dialogView.alpha=0;
    [view addSubview:dialogView];
    
    dialogView.exclusiveTouch=YES;
    dialogView.userInteractionEnabled=YES;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationCurveEaseIn animations:^{
        dialogView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
   
}

@end
