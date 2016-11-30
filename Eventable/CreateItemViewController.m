//
//  CreateItemViewController.m
//  Eventable
//
//  Created by Dylan McCrindle on 2016-11-29.
//  Copyright © 2016 Dylan-Shahab. All rights reserved.
//

#import "CreateItemViewController.h"

@interface CreateItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *itemCountField;
@property (weak, nonatomic) IBOutlet UIButton *uploadedImageButton;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (nonatomic) UIImage *uploadedImage;

@end

@implementation CreateItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.popupView.layer.cornerRadius = 10;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)newItemButton:(UIButton *)sender {
	
	//Cancel the event creation
	if([[sender currentTitle] isEqualToString: @"Cancel"]){
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	
	//Save the event
	else{
		NSLog(@"%@",self.itemNameField.text);
		NSLog(@"%@",self.itemCountField.text);
		[self dismissViewControllerAnimated:YES completion:nil];
		
	}
	
}


#pragma Custom Pictures
//Get a picture from the photo library
- (IBAction)UploadCustomPicture:(UIButton *)sender {
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;

	imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:imagePicker animated:YES completion:^{}];
	
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
	self.uploadedImage = info[UIImagePickerControllerOriginalImage];
	[picker dismissViewControllerAnimated:YES completion:^{}];
	[self.uploadedImageButton setBackgroundImage:self.uploadedImage forState:UIControlStateNormal];
}

@end
