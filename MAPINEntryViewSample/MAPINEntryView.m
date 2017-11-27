/**MIT License
 
 *Copyright (c) 2017 manisha-deshmukh
 
 *Permission is hereby granted, free of charge, to any person obtaining a copy
 *of this software and associated documentation files (the "Software"), to deal
 *in the Software without restriction, including without limitation the rights
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *copies of the Software, and to permit persons to whom the Software is
 *furnished to do so, subject to the following conditions:
 
 *The above copyright notice and this permission notice shall be included in all
 *copies or substantial portions of the Software.
 
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *SOFTWARE.
 */

#import "MAPINEntryView.h"

@interface MAPINEntryView()<UITextViewDelegate>
{
    NSMutableString *userEntryString;
}
@end

@implementation MAPINEntryView

- (void)awakeFromrNib
{
    [super awakeFromNib];
    [self initWithDefaultSettings];
}

-(void)layoutSubviews{
    [self initWithDefaultSettings];
}

-(void)initWithDefaultSettings{
    
    [[NSBundle mainBundle] loadNibNamed:@"MAPINEntryView" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    userEntryString = [[NSMutableString alloc] init];
    self.et_textField.delegate = self;
    [self setupPinView];
    [_et_textField becomeFirstResponder];
    
}

-(void)setupPinView{
    
    _pinEntryView.numberOfItemsToBeDisplayed = _numberOfItemsToBeDisplayed;
    _pinEntryView.genericLeadingTrailingSpace = _genericLeadingTrailingSpace;
    _pinEntryView.genericTopBottomSpace = _genericTopBottomSpace;
    _pinEntryView.spacingBetweenBoxes = _spacingBetweenBoxes;
    _pinEntryView.dotColor = _dotColor;
    _pinEntryView.boxColor = _boxColor;
    _pinEntryView.sizeOfDot = _sizeOfDot;
    _pinEntryView.userInput = @"";
    _pinEntryView.pinEntryDelegate = _pinContainerDelegate;
    _pinEntryView.fontSize = _fontSize;
    [_pinEntryView setNeedsDisplay];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_et_textField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (![string isEqualToString:@""] && textField.text.length >= _numberOfItemsToBeDisplayed) {
        return NO;
    }
    if ([string isEqualToString:@""]) {
        //deletion
        if (![userEntryString isEqualToString:@""]) {
            userEntryString = [[userEntryString substringWithRange:NSMakeRange(0, userEntryString.length-1)] mutableCopy];
            _pinEntryView.userInput = userEntryString;
        }
    }
    else{
        userEntryString = [[userEntryString stringByAppendingString:string] mutableCopy];
        _pinEntryView.userInput = userEntryString;
    }
    
    [_pinEntryView setNeedsDisplay];
    return YES;
}
@end


@interface PINEntryView()
{
    CGSize boxSize;
    CGFloat yCoordinateForBox;
}

@end

@implementation PINEntryView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    [super drawRect:rect];
    boxSize = [self calculateSizeOfIndivisualBox];
    yCoordinateForBox =  _genericTopBottomSpace;
    
    if ([_userInput isEqualToString:@""]) {
        [self drawBoxes];
    }
    else{
        //draw the text, dots and boxes based on the length of UserInput
        if ([_userInput length] > _numberOfItemsToBeDisplayed) {
            _userInput = [_userInput substringWithRange:NSMakeRange(0, _numberOfItemsToBeDisplayed)];
        }
        [self drawBoxes];
        [self drawTextAccordingToUserInput];
    }
}

-(void)drawBoxes{
    
    for(int i = 0;i<_numberOfItemsToBeDisplayed;i++){
        
        CGRect boxRect = CGRectMake((i*(boxSize.width+_spacingBetweenBoxes) + _genericLeadingTrailingSpace), yCoordinateForBox, boxSize.width, boxSize.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, _boxColor.CGColor);
        CGContextFillRect(context, boxRect);
    }
}

-(void)drawTextAccordingToUserInput{
    
    for (int i = 0; i< [_userInput length]; i++) {
        if (i == _userInput.length-1) {
            //draw text
            CGFloat xCordinate = (i*(boxSize.width+_spacingBetweenBoxes) + _genericLeadingTrailingSpace) ;
            [self drawText:xCordinate yPosition:(yCoordinateForBox + (boxSize.height/2) - _fontSize/2) canvasWidth:boxSize.width canvasHeight:boxSize.height];
            
            if (i == _numberOfItemsToBeDisplayed-1) {
                //last entry
                [_pinEntryDelegate enteredCompleteInput: _userInput];
            }
        }
        else{
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGFloat centerX = _genericLeadingTrailingSpace+i*(_spacingBetweenBoxes+boxSize.width)+(boxSize.width/2);
            CGFloat centerY = _genericTopBottomSpace + (self.bounds.size.height - 2*_genericTopBottomSpace)/2;
            
            CGRect dotRect = CGRectMake((centerX - _sizeOfDot/2), (centerY- _sizeOfDot/2), _sizeOfDot, _sizeOfDot);
            CGContextSetFillColorWithColor(context, _dotColor.CGColor);
            CGContextFillEllipseInRect(context, dotRect);
        }
    }
}

- (void)drawText:(CGFloat)xPosition yPosition:(CGFloat)yPosition canvasWidth:(CGFloat)canvasWidth canvasHeight:(CGFloat)canvasHeight
{
    //Draw Text
    CGRect textRect = CGRectMake(xPosition, yPosition, canvasWidth, canvasHeight);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: _fontSize], NSForegroundColorAttributeName:_dotColor, NSParagraphStyleAttributeName: textStyle};
    
    [[_userInput substringFromIndex:(_userInput.length - 1)] drawInRect: textRect withAttributes: textFontAttributes];
}

-(CGSize)calculateSizeOfIndivisualBox{
    
    CGFloat desiredWidth = (self.bounds.size.width - 2*_genericLeadingTrailingSpace - _spacingBetweenBoxes*(_numberOfItemsToBeDisplayed -1))/_numberOfItemsToBeDisplayed;
    CGFloat desiredHeight = self.bounds.size.height - 2*_genericTopBottomSpace;
    return CGSizeMake(desiredWidth, desiredHeight);
}
@end

