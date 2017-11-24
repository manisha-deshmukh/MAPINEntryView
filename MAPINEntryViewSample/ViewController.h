//
//  ViewController.h
//  MAPINEntryViewSample
//
//  Created by Manisha.Deshmukh on 24/11/17.
//  Copyright © 2017 Manisha.Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPINEntryView.h"

@interface ViewController : UIViewController<PINEntryViewDelegate>

@property (weak, nonatomic) IBOutlet MAPINEntryView *pinEntryView;


@end

