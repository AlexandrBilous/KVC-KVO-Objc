//
//  Student.h
//  KVC-KVO-OBJC
//
//  Created by Marentilo on 03.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum {
    StudentGenderMale,
    StudentGenderFemale
} StudentGender;

@interface Student : NSObject

@property (strong, nonatomic) NSString * firstName;
@property (strong, nonatomic) NSString * lastName;
@property (assign, nonatomic) CGFloat grade;
@property (assign, nonatomic) StudentGender gender;
@property (strong, nonatomic) NSDate * dateOfBirth;
@property (weak, nonatomic) Student * mate;
@property (weak, nonatomic) NSArray * names;

- (void) setupProperties;

-(void)setupFirstName;
-(void)setupLastName;
-(void)setupGrade;
-(void)setupGender;
-(void)setupDate;

-(NSUInteger) countOfGrade;


- (void) setToNil;

@end

NS_ASSUME_NONNULL_END
