//
//  CreateEventViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-29.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//
#import "DataManager.h"

#import "CreateEventViewController.h"

#import "Event+CoreDataClass.h"

@interface CreateEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eventNameLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *eventDatePicker;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.popupView.layer.cornerRadius = 10;
	[self.eventNameLabel becomeFirstResponder];
}

- (IBAction)newEventButton:(UIButton *)sender {
	
	//Cancel the event creation
	if([[sender currentTitle] isEqualToString: @"Cancel"]){
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	
	//Save the event
	else{
		NSLog(@"%@",self.eventNameLabel.text);
		NSLog(@"%@",self.eventDatePicker.date);
        
        Event *event = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Event"
                        inManagedObjectContext:[DataManager sharedInstance].context];
        
        event.title = self.eventNameLabel.text;
        event.date = self.eventDatePicker.date;
        event.location = @"Montreal";
        
        [[DataManager sharedInstance] saveContext];
        
		[self dismissViewControllerAnimated:YES completion:nil];
		
	}

}



@end
