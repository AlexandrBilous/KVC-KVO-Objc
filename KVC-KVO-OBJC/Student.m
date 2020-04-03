//
//  Student.m
//  KVC-KVO-OBJC
//
//  Created by Marentilo on 03.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void) setToNil {
    
    
    [self willChangeValueForKey:@"lastName"];
    [self willChangeValueForKey:@"firstName"];
    [self willChangeValueForKey:@"grade"];
    [self willChangeValueForKey:@"dateOfBirth"];
    [self willChangeValueForKey:@"gender"];
    _lastName = [NSString string];
    _firstName = [NSString string];
    _grade = 0;
    _dateOfBirth = [NSString string];
    _gender = 0;
    
    [self didChangeValueForKey: @"lastName"];
    [self didChangeValueForKey: @"firstName"];
    [self didChangeValueForKey: @"grade"];
    [self didChangeValueForKey: @"dateOfBirth"];
    [self didChangeValueForKey: @"gender"];
}


- (void)setupProperties {
    [self setupFirstName];
    [self setupLastName];
    [self setupGrade];
    [self setupDate];
    [self setupGender];
    
}

- (void) setupGender {
    self.gender = arc4random() % 1000 > 500;
}

- (void) setupFirstName {
    NSArray * arrayOfNames = [NSArray arrayWithObjects:@"Alexandr", @"Jura", @"Aleksei", @"Karina", @"Marina", @"Anna", @"Andrei", @"Victor", @"Dmitriy", @"Oleg", @"Pavel", @"Vladimir", @"Konstantin", @"Denis", @"Matvei", @"Olga", @"Nikolay", @"Martin", @"Valentin", @"Daniil", nil];
    
    NSInteger randomIndex = arc4random() % ([arrayOfNames count] - 1);
    self.firstName = [arrayOfNames objectAtIndex: randomIndex];
}

- (void) setupLastName {
    NSArray * arrayOfLastNames = [NSArray arrayWithObjects:@"Bilous", @"Totoeva", @"Baran", @"Litvinchuk", @"Serbin", @"Pavlock", @"Mironchuk", @"Vaskinskiy", @"Skutarenko", @"Ivanov", @"Petrov", @"Holodov", @"Gavriluck", @"Ostapshik", @"Gorbunov", @"Osadchiy", @"Potapenko", @"Klochkova", @"Denisova", @"Shishenok", nil];
    
    NSInteger randomIndex = arc4random() % ([arrayOfLastNames count] - 1);
    self.lastName = [arrayOfLastNames objectAtIndex: randomIndex];
}

- (void) setupDate {
    NSInteger randomInt = arc4random() % 40 * 3600 * 24 * 365;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970: (double)(randomInt)];
    
    self.dateOfBirth = date;
}

- (void) setupGrade {
    CGFloat randomIndex = 3.0 + arc4random() % 30000 / 15000.0;
    
    self.grade = randomIndex;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

- (NSUInteger)countOfGrade {
    return 20;
}



@end
