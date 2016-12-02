//
//  CreateItemViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-29.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//
#import "DataManager.h"
#import "CreateItemViewController.h"

#import "Item+CoreDataClass.h"
#import "Event+CoreDataClass.h"

@interface CreateItemViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *itemCountField;
@property (weak, nonatomic) IBOutlet UIButton *uploadedImageButton;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (nonatomic) UIImage *uploadedImage;
@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) NSString *picturePathName;

@end

@implementation CreateItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.popupView.layer.cornerRadius = 10;
	[self.itemNameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)releaseKeyboardTap:(UITapGestureRecognizer *)sender {
	[self.view endEditing:YES];
}


- (IBAction)newItemButton:(UIButton *)sender {
	
	//Cancel the event creation
	if([[sender currentTitle] isEqualToString: @"Cancel"]){
		[self.view endEditing:YES];
		[self dismissViewControllerAnimated:YES completion:^{
			[self.delegate reloadItemCollection];
		}];
	}
	
	//Save the item
	else{
        
        Item *item = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Item"
                      inManagedObjectContext:[DataManager sharedInstance].context];
		
        item.name = self.itemNameField.text;
		item.have = self.itemHave;
        item.photoName = self.picturePathName;
        item.quantity = [self.itemCountField.text intValue];
		
		[self.itemEvent addItemsObject:item];
        
		[[DataManager sharedInstance] saveContext];
		
		[self dismissViewControllerAnimated:YES completion:^{
			[self.delegate reloadItemCollection];
		}];
	}
	
}


#pragma Custom Pictures
//Get a picture from the photo library
- (IBAction)UploadCustomPicture:(UIButton *)sender {
	
	[self.itemNameField resignFirstResponder];
	[self.itemCountField resignFirstResponder];
	
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	//cancel
	UIAlertAction* cancel = [UIAlertAction
							  actionWithTitle:@"Cancel"
							  style:UIAlertActionStyleCancel
							  handler:^(UIAlertAction * action)
							  {}];
	
	//If they choose the camera
	UIAlertAction* camera = [UIAlertAction
							  actionWithTitle:@"Take Photo"
							  style:UIAlertActionStyleDefault
							  handler:^(UIAlertAction * action)
							  {
								  self.imagePickerController= [[UIImagePickerController alloc] init];
								  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
								  self.imagePickerController.delegate = self;
								  self.imagePickerController.showsCameraControls = YES;
								  self.imagePickerController.allowsEditing = YES;
								  
//								  [[NSBundle mainBundle] loadNibNamed:@"cameraOverlay" owner:self options:nil];
//								  self.overlayView.frame = self.imagePickerController.cameraOverlayView.frame;
//								  self.imagePickerController.cameraOverlayView = self.overlayView;
//								  self.overlayView = nil;

								  
								  [self presentViewController:self.imagePickerController animated:YES completion:^{
								  }];
							  }];
	
	//If they choose the library
	UIAlertAction* library = [UIAlertAction
							  actionWithTitle:@"Choose Existing"
							  style:UIAlertActionStyleDefault
							  handler:^(UIAlertAction * action)
							  {
								  self.imagePickerController= [[UIImagePickerController alloc] init];
								  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
								  self.imagePickerController.delegate = self;
								  self.imagePickerController.allowsEditing = YES;
								  [self presentViewController:self.imagePickerController animated:YES completion:^{}];
							  }];
	
	
	
	//Add buttons to the alert controller
	[alert addAction:cancel];
	[alert addAction:camera];
	[alert addAction:library];
	[self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
	self.uploadedImage = info[UIImagePickerControllerEditedImage];
	[picker dismissViewControllerAnimated:YES completion:^{}];
	[self.uploadedImageButton setBackgroundImage:self.uploadedImage forState:UIControlStateNormal];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd-HH-mm-ss-a"];
	//[dateFormat setDateStyle:NSDateFormatterLongStyle];
	
	self.picturePathName = [NSString stringWithFormat:@"%@.png", [dateFormat stringFromDate: [NSDate date]]];

	
	if (self.uploadedImage != nil){
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString* path = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@",self.picturePathName]];
		NSData* data = UIImagePNGRepresentation(self.uploadedImage);
		[data writeToFile:path atomically:YES];
	}
	
}
- (IBAction)takePhoto:(id)sender
{
	[self.imagePickerController takePicture];
}


@end
