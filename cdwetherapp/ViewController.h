//
//  ViewController.h
//  cdwetherapp
//
//  Created by Student-15 on 09/11/17.
//  Copyright (c) 2017 chaitali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define key1 @"629ba7ad2520a3d580f52e2827b5f547"
#define url @"https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=629ba7ad2520a3d580f52e2827b5f547&units=metric"

@interface ViewController : UIViewController<UITextFieldDelegate>
@property float la;
@property float lo;
@property NSString *myKey;
@property NSMutableDictionary *d1,*d2,*d3,*d4;
@property NSMutableArray *a1,*a2,*a3;
@property (strong, nonatomic) IBOutlet UITextField *getLocation;

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UITextField *Temp;


@property (strong, nonatomic) IBOutlet UITextField *Humidity;

@property (strong, nonatomic) IBOutlet UITextField *Description;


@end

