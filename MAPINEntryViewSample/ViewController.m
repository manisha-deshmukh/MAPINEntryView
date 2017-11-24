//
//  ViewController.m
//  MAPINEntryViewSample
//
//  Created by Manisha.Deshmukh on 24/11/17.
//  Copyright © 2017 Manisha.Deshmukh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupPinCotainerView];
}

/*
 - It Setup PinEntry View Paramters and delegate
 */
-(void)setupPinCotainerView{
    _pinEntryView.numberOfItemsToBeDisplayed = 6;
    _pinEntryView.genericLeadingTrailingSpace = 24.0;
    _pinEntryView.genericTopBottomSpace = 0.0;
    _pinEntryView.spacingBetweenBoxes = 4.0;
    _pinEntryView.dotColor = [UIColor blackColor];
    _pinEntryView.boxColor = [UIColor lightGrayColor];
    _pinEntryView.sizeOfDot = 14.0;
    _pinEntryView.pinContainerDelegate = self;
    _pinEntryView.fontSize = 18.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PINEntryViewDelegate
/*
 - It informs the delegatee VC to proceed with the action and gives back the user input for further actions
 */
-(void)enteredCompleteInput:(NSString *)enteredInput{
    NSLog(@"Entered Input:%@", enteredInput);
    //proceed with the action
}
@end
