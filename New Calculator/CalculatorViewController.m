//
//  CalculatorController.m
//  New Calculator
//
//  Created by Sky on 3/26/15.
//  Copyright (c) 2015 com.sky. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end

@implementation CalculatorViewController
{
    NSString *input1;                     //To store users First Input
    NSString *input2;                     //To store users third Input
    NSString *tempBuffer;                 //
    NSString *result;                     //To store operation result
    BOOL operationButtonTapped;           //
    BOOL equalToTapped;
    BOOL decimalButtonTapped;
    int operationButtonTagValue;          //To identify which operaiton button is tapped
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainLabel.text = @"0";
    result = @"0";
    input1 = @"0";
    input2 = nil;
    operationButtonTapped = false;
    equalToTapped = false;
    decimalButtonTapped = false;
    operationButtonTapped = false;
    operationButtonTagValue = 17;  // change1
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- NumericButtonTapped
// Tapping on any Numeric Button from 0-9 using tag values
- (IBAction)buttonTapped:(id)sender
{
    if (operationButtonTapped == false)             //This is input1
    {
        UIButton *numberButton = (id) sender;
        NSUInteger tag = numberButton.tag;
        NSString *tempBuffer1 = [NSString stringWithFormat:@"%lu",(unsigned long)tag];
        if ([input1 isEqual: @"0"])                //first digit of first number entered
        {
            input1 = [input1 substringFromIndex:1];
            input1 = [input1 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input1;
            NSLog(@"input 1 first digit is: %@", input1);
        }
        else    //concate other digits to the first digit entered from above
        {
            input1 = [input1 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input1;
            NSLog(@"input 1 is: %@", input1);
        }
    }
    else                //This is input2
    {
        UIButton *numberButton = (id) sender;
        NSUInteger tag = numberButton.tag;
        NSString *tempBuffer1 = [NSString stringWithFormat:@"%lu",(unsigned long)tag];
        NSLog(@"self.MainLabel.text %@", self.mainLabel.text);
        if ([input2 isEqual: @"0"])                //first digit of second number entered
        {
           // input2 = tempBuffer1;//was @"0"
            input2 = [input2 substringFromIndex:1];
            input2 = [input2 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input2;
            NSLog(@"input 2 first digit is: %@", input2);
        }
        else
        {
            input2 = [input2 stringByAppendingString:tempBuffer1];
            _mainLabel.text = input2;
            NSLog(@"Complete input 2 is: %@", input2);
        }
    }
        
}

#pragma mark- ClearButtonIsTapped
// A/C button on calculator to reset the calculator & display
- (IBAction)clearTapped:(id)sender
{
    self.mainLabel.text = @"0";
    result = @"0";
    input1 = @"0";
    input2 = nil;
    operationButtonTapped = false;
    equalToTapped = false;
    decimalButtonTapped = false;
    operationButtonTapped = false;
    operationButtonTagValue = 17;
}

#pragma mark- operationButtonTapped
//Uses Tag value of operators to decide which operation to perform
- (IBAction)operationButtonTapped:(id)sender
{
    UIButton *operationButton = (id) sender;
    NSUInteger tag = operationButton.tag;
    input1 = _mainLabel.text;
    
    operationButtonTapped = true;

    decimalButtonTapped = false;
    
    input2 = @"0"; // Change1  added to start adding first digit of 2nd input to input2 

    
    if (operationButtonTapped)
    {
        switch (tag)
        {
            case 11: //division
                operationButtonTagValue = 11;
                break;
                
            case 12:  //multiplication
                operationButtonTagValue = 12;
                break;
            
            case 13:  //addition
                operationButtonTagValue = 13;
                break;
                
            case 14:  //subtraction
                operationButtonTagValue = 14;
                break;
                
            default:
                break;
        }
    }
}

#pragma mark- SignChangeOperatorTapped
 - (IBAction)signChangeOperatorTapped:(id)sender
 {

     if ([input1  isEqual: @"0"])
         {
             self.mainLabel.text = @"0";
         }
     else
        {
            if (operationButtonTapped == false)  //This is input1
             {
                 float temp = [self.mainLabel.text floatValue];
                 temp  = -(temp);
                 input1 = [NSString stringWithFormat:@"%g",temp];
                 _mainLabel.text = input1;
             }
            else  //This is input 2
            {
                 float temp = [self.mainLabel.text floatValue];
                 temp  = -(temp);
                 input2 = [NSString stringWithFormat:@"%g",temp];
                 _mainLabel.text = input2;
         }
     }
 }

#pragma mark- DecimalButtonTapped
- (IBAction)decimalButtonTapped:(id)sender
{
    if (operationButtonTapped == false) //this is input 1
        {
            if (decimalButtonTapped == false) // decimal is tapped first time for input1
           {
            input1 = [input1 stringByAppendingFormat:@"."];
            _mainLabel.text = input1;
            NSLog(@"the decimal formatted string is: %@", input1);
               decimalButtonTapped = true;
           }
            else
            {
                _mainLabel.text = input1;
            }

        }
        else                    //this is input 2
        {
           
            if (decimalButtonTapped == false) //decimal is tapped first time for input2
            {
            input2 = @"0"; //Initilized to O, because . we cannot append anything to  input2=nil
            input2 = [input2 stringByAppendingString:@"."];
            _mainLabel.text = input2;
                               decimalButtonTapped = true;
            }
            else
            {
                _mainLabel.text = input2;
            }
        }
}

#pragma mark- EqualToButtonTapped
- (IBAction)equalsToIsTapped:(id)sender
{
    NSString *str1 = input1;
    long double theFirstOperandValue = [str1 floatValue];
    NSString *str2 = input2;
    long double theSecondOperandValue = [str2 floatValue];
    
    if (input2 != nil)      //To make Tapping on = function like calculator
    {
        theSecondOperandValue = theSecondOperandValue;
    }
    else
    {
        theSecondOperandValue = theFirstOperandValue;
    }
    
    long double answer;
     if (equalToTapped == false)   //EqualToTapped First Time
     {
        switch (operationButtonTagValue)
         {
            case 11:
                answer = theFirstOperandValue/theSecondOperandValue;
                result = [NSString stringWithFormat:@"%Lg", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;

            case 12:
                answer = theFirstOperandValue*theSecondOperandValue;
                result = [NSString stringWithFormat:@"%Lg", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;
                
            case 13:
                answer = theFirstOperandValue+theSecondOperandValue;
                result = [NSString stringWithFormat:@"%Lg", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;
                
            case 14:
                answer = theFirstOperandValue-theSecondOperandValue;
                result = [NSString stringWithFormat:@"%Lg", answer];
                _mainLabel.text = result;
                equalToTapped = true;
                break;
        }
      }
      else  //Equal to tapped second time
      {
         NSString *tempResult1 = result;
         answer = [tempResult1 floatValue];
         switch (operationButtonTagValue)
         {
             case 11:
                 answer = answer/theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 12:
                 answer = answer*theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 13:
                 answer = answer+theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
                 
             case 14:
                 answer = answer-theSecondOperandValue;
                 result = [NSString stringWithFormat:@"%Lg", answer];
                 _mainLabel.text = result;
                 break;
           }
      }
}

#pragma mark- Percentage Operator
- (IBAction)percentageButtonTapped:(id)sender
{
    NSString *temp = self.mainLabel.text;
    long double percentage = [temp floatValue];
    percentage = percentage/100 ;
    result = [NSString stringWithFormat:@"%Lg", percentage];
    _mainLabel.text = result;
    operationButtonTagValue = 17;
}

@end
