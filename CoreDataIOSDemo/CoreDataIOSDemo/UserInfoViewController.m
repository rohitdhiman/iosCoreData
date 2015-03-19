//
//  UserInfoViewController.m
//  CoreDataIOSDemo
//
//  Created by Rohit Dhiman  on 14/08/14.
//  Copyright (c) 2014 Anchanto. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AppDelegate.h"

#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize nameTextField = _nameTextField;
@synthesize addressTextField = _addressTextField;
@synthesize phoneTextField = _phoneTextField;
@synthesize saveButton = _saveButton;
@synthesize findButton = _findButton;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark Button Tapped method
- (IBAction)saveButtonTapped:(id)sender
{
    NSManagedObjectContext *context = [APPDELEGATE managedObjectContext];
    NSManagedObject *newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts"
                                                                inManagedObjectContext:context];
    
    [newContact setValue:[NSString stringWithFormat:@"%@",_nameTextField.text] forKey:@"name"];
    [newContact setValue:[NSString stringWithFormat:@"%@",_addressTextField.text] forKey:@"address"];
    [newContact setValue:[NSString stringWithFormat:@"%@",_phoneTextField.text] forKey:@"phone"];
    
    NSError *error;
    [context save:&error];
    _nameTextField.text = @"";
    _addressTextField.text = @"";
    _phoneTextField.text = @"";
    
    
    UIAlertView *save = [[UIAlertView alloc] initWithTitle:@"" message:@"saved"
                              delegate:self cancelButtonTitle:@"OK"
                     otherButtonTitles:nil, nil];
    [save show];
    
    
}

#pragma mark Find Button with core data
//Find record code
- (IBAction)findButtonTapped:(id)sender
{
    NSManagedObjectContext *context = [APPDELEGATE managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Contacts"
                                                         inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name = %@)",_nameTextField.text];
    [request setPredicate:predicate];
    
    NSManagedObject *managedObject = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    if([objects count] == 0)
    {
        UIAlertView *save = [[UIAlertView alloc] initWithTitle:@"" message:@"No record found"
                                                      delegate:self cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [save show];
    }
    else
    {
        managedObject = objects[0];
        _nameTextField.text = [NSString stringWithFormat:@"%@",[managedObject valueForKey:@"name"]];
        _addressTextField.text = [NSString stringWithFormat:@"%@",[managedObject valueForKey:@"address"]];
        _phoneTextField.text = [NSString stringWithFormat:@"%@",[managedObject valueForKey:@"phone"]];
        
        UIAlertView *save = [[UIAlertView alloc] initWithTitle:@""
                                                       message:[NSString stringWithFormat:@"%d Record found",[objects count]]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [save show];
    }
    
    
    
}
//TextField Delegate method
#pragma mark
#pragma mark TextField Delegate method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
