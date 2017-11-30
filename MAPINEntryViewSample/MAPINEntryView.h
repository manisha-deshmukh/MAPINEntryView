
#import <UIKit/UIKit.h>
@protocol PINEntryViewDelegate

-(void)enteredCompleteInput:(NSString *)enteredInput;

@end

@interface PINEntryView : UIView
@property(nonatomic, strong) NSString *userInput;
@property(nonatomic, assign)NSInteger numberOfItemsToBeDisplayed;
@property(nonatomic, assign)CGFloat spacingBetweenBoxes;
@property(nonatomic, assign)CGFloat genericLeadingTrailingSpace;
@property(nonatomic, assign)CGFloat genericTopBottomSpace;
@property(nonatomic, assign)CGFloat sizeOfDot;
@property(assign)BOOL needToShowBorder;
@property(nonatomic, assign)CGFloat borderWidth;

@property(nonatomic, assign)CGFloat fontSize;

@property(nonatomic, strong)UIColor *dotColor;
@property(nonatomic, strong)UIColor *boxColor;
@property(nonatomic, strong)UIColor *borderColor;

@property(nonatomic, strong)UITextField *hiddenTextField;
@property(nonatomic, assign) id pinEntryDelegate;

@end

@interface MAPINEntryView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *hiddenTextField;
@property (weak, nonatomic) IBOutlet PINEntryView *pinEntryView;

@property(nonatomic, assign)NSInteger numberOfItemsToBeDisplayed;

@property(nonatomic, assign)CGFloat spacingBetweenBoxes;
@property(nonatomic, assign)CGFloat genericLeadingTrailingSpace;
@property(nonatomic, assign)CGFloat genericTopBottomSpace;

@property(nonatomic, assign)CGFloat sizeOfDot;
@property(nonatomic, strong)UIColor *dotColor;

@property(assign)BOOL needToShowBorder;
@property(nonatomic, assign)CGFloat borderWidth;
@property(nonatomic, strong)UIColor *borderColor;


@property(nonatomic, assign)CGFloat fontSize;
@property(nonatomic, strong)UIColor *boxColor;

@property(nonatomic, assign) id pinContainerDelegate;



@end
