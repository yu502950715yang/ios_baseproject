//
//  ValidateViewController.m
//  BasicProject
//
//  Created by 余洋 on 2017/10/30.
//  Copyright © 2017年 余洋. All rights reserved.
//

#import "ValidateViewController.h"
#import "NSString+Verify.h"

@interface ValidateViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;
@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property (weak, nonatomic) IBOutlet UITextField *accountNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *taxNoTextField;

@end

@implementation ValidateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_emailTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_idCardTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_IPTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_accountNumberTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_taxNoTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 监听textfield输入内容，并对其进行验证
-(void)textfieldDidChange:(id)sender {
    UITextField *textField = (UITextField *)sender;
    switch (textField.tag) {
        case 1:
            [self changeTextField:textField valid:[textField.text isValidEmail]];
            break;
        case 2:
            [self changeTextField:textField valid:[textField.text isValidPhoneNum]];
            break;
        case 3:
            [self changeTextField:textField valid:[textField.text isValidIdCardNum]];
            break;
        case 4:
            [self changeTextField:textField valid:[textField.text isValidIP]];
            break;
        case 5:
            [self changeTextField:textField valid:[textField.text isValidWithMinLenth:4 maxLenth:12 containChinese:NO firstCannotBeDigtal:YES]];
            break;
        default:
            [self changeTextField:textField valid:[textField.text isValidTaxNo]];
            break;
    }
}

#pragma mark 改变textfield样式
-(void)changeTextField:(UITextField *)textField valid:(BOOL)valid {
    UIColor *color = valid?[UIColor blackColor] : [UIColor redColor];
    textField.layer.borderColor = color.CGColor;
    if (valid) {
        textField.layer.borderWidth = 0;
    } else {
        textField.layer.borderWidth = 0.5;
    }
}


@end
