//
//  ViewController.h
//  KVC-KVO-OBJC
//
//  Created by Marentilo on 03.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "NSArray+Observing.h"

@interface ViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSArray * arrayOfStudents;
@property (strong, nonatomic) NSArray * array;
@property (strong, nonatomic) Student * student;


@end

