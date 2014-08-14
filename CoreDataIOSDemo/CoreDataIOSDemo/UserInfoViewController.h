//
//  UserInfoViewController.h
//  CoreDataIOSDemo
//
//  Created by Rohit Dhiman  on 14/08/14.
//  Copyright (c) 2014 Anchanto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *addressTextField;
@property (nonatomic, strong) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *findButton;

- (IBAction)saveButtonTapped:(id)sender;
- (IBAction)findButtonTapped:(id)sender;

@end
