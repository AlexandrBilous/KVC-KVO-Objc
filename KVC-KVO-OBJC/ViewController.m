//
//  ViewController.m
//  KVC-KVO-OBJC
//
//  Created by Marentilo on 03.04.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray * titles;
@property (weak, nonatomic) UITextField * nameField;
@property (weak, nonatomic) UITextField * lastNameField;
@property (weak, nonatomic) UITextField * gradeField;
@property (weak, nonatomic) UITextField * dateField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void) setupView {
    self.student = [[Student alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    self.titles = @[@"Gender", @"First name", @"Last name", @"Grade", @"Date of Birth"];
    
    UIBarButtonItem * deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(deleteButtonPressed:)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    
    [self.student addObserver:self forKeyPath:@"lastName" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"grade" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];
    [self.student addObserver:self forKeyPath:@"dateOfBirth" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];
    
     [self.student addObserver:self forKeyPath:@"mate" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];
    
    Student * student1 = [[Student alloc] init];
    Student * student2 = [[Student alloc] init];
    Student * student3 = [[Student alloc] init];
    Student * student4 = [[Student alloc] init];
    Student * student5 = [[Student alloc] init];
    Student * student6 = [[Student alloc] init];
    
    self.student.mate = student1;
    student1.mate = student2;
    student2.mate = student3;
    student3.mate = student4;
    student4.mate = student5;
    student5.mate = student6;
    student6.mate = self.student;
    
    NSArray * students = @[student1, student2, student3, self.student, student4, student5, student6];
    
    for (Student * item in students) {
        [item setupProperties];
    }
    
    [self.student addObserver:self forKeyPath:@"firstName" options:NSKeyValueObservingOptionNew  | NSKeyValueObservingOptionOld context:nil];


    NSString * key = @"mate";
    NSString * addKey = @".mate";
    
//    for (Student * student in students) {
//        NSLog(@"%@ will change name", student);
//        [student setValue:[student valueForKeyPath:[key stringByAppendingString:@".firstName"]] forKeyPath:@"firstName"];
//        NSLog(@"%@ did change name", student);
//        key = [key stringByAppendingString:addKey];
//        NSLog(@"---------");
//    }

    
    NSMutableArray * array = [NSMutableArray array];
    
    for (int i = 0; i < 15; i++) {
        Student * student = [[Student alloc] init];
        [student setupProperties];
        [array addObject:student];
    }
    
    self.array = array;
//
//    NSLog(@"All names: %@", [array valueForKeyPath:@"@unionOfObjects.firstName"]);
//    NSLog(@"All names without dublicate: %@", [array valueForKeyPath:@"@distinctUnionOfObjects.firstName"]);
//    NSLog(@"The earliest student was born: %@", [array valueForKeyPath:@"@max.dateOfBirth"]);
//    NSLog(@"The max: %.3f", [[array valueForKeyPath:@"@max.grade"] floatValue]);
//    NSLog(@"The min: %.3f", [[array valueForKeyPath:@"@min.grade"] floatValue]);
//    NSLog(@"The avg: %.3f", [[array valueForKeyPath:@"@avg.grade"] floatValue]);
//    NSLog(@"The sum: %.3f", [[array valueForKeyPath:@"@sum.grade"] floatValue]);
//    NSLog(@"CountOfGrade: %@", [array valueForKeyPath:@"@countOfGrade"]);
    
        
    
    NSLog(@"lolKek: %@", [array valueForKeyPath:@"@lolKek"]);

//    NSLog(@"Number of students: %@", [[array valueForKeyPath:@"@unionOfObjects.grade"] valueForKeyPath:@"@count"]);
//    NSLog(@"Number of students: %d", [[[array valueForKeyPath:@"@unionOfObjects.grade"] valueForKeyPath:@"@count"] integerValue]);
//    NSLog(@"Number of students: %d", [[array valueForKeyPath:@"@count"] integerValue]);

}


- (void) setupCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath *) indexpath  {
    if (indexpath.row == 0 ) {
        UISegmentedControl * controller = [[UISegmentedControl alloc] initWithItems:@[@"Male", @"Female"]];
        controller.translatesAutoresizingMaskIntoConstraints = false;
        [cell.contentView addSubview:controller];
        [controller addTarget:self action:@selector(genderChanged:) forControlEvents:UIControlEventValueChanged];
        [[controller.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant:8] setActive:YES];
        [[controller.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant:-8]  setActive:YES];
        [[controller.leadingAnchor constraintEqualToAnchor: cell.contentView.centerXAnchor constant:0]  setActive:YES];
    } else {
        UITextField * field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        field.delegate = self;
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.tag = indexpath.row;
        field.placeholder = [NSString stringWithFormat: @"Enter %@", [self.titles objectAtIndex:indexpath.row]];
        [cell.contentView addSubview:field];
        field.translatesAutoresizingMaskIntoConstraints = false;
        
        switch (indexpath.row) {
            case 1:
                self.nameField = field;
                break;
            case 2:
                self.lastNameField = field;
                break;
            case 3:
                self.gradeField = field;
                break;
            case 4:
                self.dateField = field;
                break;
            default:
                break;
        }
        
        UIButton * button = [UIButton systemButtonWithImage:[UIImage imageNamed:@"refresh"] target:self action:@selector(refreshButtonPressed:)];
        button.tag = indexpath.row;
        [cell.contentView addSubview: button];
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        [[button.topAnchor constraintEqualToAnchor: cell.contentView.topAnchor constant:8] setActive:YES];
        [[button.bottomAnchor constraintEqualToAnchor: cell.contentView.bottomAnchor constant:-8]  setActive:YES];
        [[button.trailingAnchor constraintEqualToAnchor: cell.contentView.trailingAnchor constant:-20]  setActive:YES];
        
        [[field.centerYAnchor constraintEqualToAnchor: button.centerYAnchor constant:0]  setActive:YES];
        [[field.trailingAnchor constraintEqualToAnchor: button.leadingAnchor constant:-20]  setActive:YES];
    }
}


// MARK: - Observer method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change value for object: %@ \nwith keyPath: %@, changes: %@", object, keyPath, change);
}


// MARK: - Refresh data

- (void) refreshFirstName {
    [self.student setupFirstName];
    self.nameField.text = self.student.firstName;
}

- (void) refreshLastName {
    [self.student setupLastName];
    self.lastNameField.text = self.student.lastName;
}

- (void) refreshDate {
    [self.student setupDate];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = [NSCalendar currentCalendar];
    [formatter setDateFormat: @"dd-MMM-YYYY"];
    
    self.dateField.text = [formatter stringFromDate: self.student.dateOfBirth];
}

- (void) refreshGrade {
    [self.student setupGrade];
    self.gradeField.text = [NSString stringWithFormat:@"%.2f", self.student.grade];
}

// MARK: - Actions

- (void) refreshButtonPressed: (UIButton*) sender {
    switch (sender.tag) {
        case 1:
            [self refreshFirstName];
            break;
        case 2:
            [self refreshLastName];
            break;
        case 3:
            [self refreshGrade];
            break;
        case 4:
            [self refreshDate];
            break;
        default:
            break;
    }
}

- (void) genderChanged: (UISegmentedControl*) sender {
    [self.student setGender: sender.selectedSegmentIndex];
}

- (void) deleteButtonPressed: (UIBarButtonItem*) sender {
    [self.student setToNil];
    
    for (UITextField* text in @[_nameField, _lastNameField, _gradeField, _dateField]) {
        text.text = @"";
        text.placeholder = @"Enter value";
    }
}


// MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    [self setupCell:cell atIndexPath: indexPath];
    return cell;
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    
}



@end
