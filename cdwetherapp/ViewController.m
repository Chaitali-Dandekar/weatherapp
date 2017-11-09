//
//  ViewController.m
//  cdwetherapp
//
//  Created by Student-15 on 09/11/17.
//  Copyright (c) 2017 chaitali. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myKey=key1;
    _getLocation.delegate=self;
    _Temp.delegate=self;
    _Humidity.delegate=self;
    _Description.delegate=self;
//    self.tf1.delegate=self;
    // Do any additional setup after loading the view, typically from a nib.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *location=_getLocation.text;
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         
         if (placemarks && placemarks.count>0)
         {
             CLPlacemark *topresult=[placemarks objectAtIndex:0];
             MKPlacemark *placemark=[[MKPlacemark alloc]initWithPlacemark:topresult];
             MKCoordinateRegion region=_myMapView.region;
             region.center=placemark.region.center;
             region.span.longitudeDelta/=8.0;
             region.span.latitudeDelta/=8.0;
             [self.myMapView setRegion:region animated:YES];
             [self.myMapView addAnnotation:placemark];
             
             self.la=region.center.latitude;
             self.lo=region.center.longitude;
           //  NSLog(@"lat:%f lon:%f",self.a,self.b);
             [self getLocationDetailWithLatitude:self.la andWithLongitude:self.lo andWithKey:self.myKey];
             [self parseData];
         }
     }];
    
    
    
 
    return YES;
}


-(void)getLocationDetailWithLatitude:(float)lat1 andWithLongitude:(float)lon1 andWithKey:(NSString *)newKey

{
    NSString *str=[NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%@&units=metric",lat1,lon1,newKey];
    NSLog(@"Search Term in Browser: %@",str);
}
-(void)parseData
{
    NSString *str=@"https://api.openweathermap.org/data/2.5/weather?lat=18.520763&lon=73.884384&appid=629ba7ad2520a3d580f52e2827b5f547&units=metric";
    
    NSURL *myurl=[NSURL URLWithString:str];
    
    
    
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:myurl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        
        NSHTTPURLResponse *myresponse=(NSHTTPURLResponse *)response;
        
        
        
        if (myresponse.statusCode==200)
            
        {
            
            if (data)
                
            {
                
                NSLog(@"Data Found");
                
                NSLog(@"Data is: %@",response);
                
                //following code is imp
                
                NSArray *myarray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                
                
                if (error)
                    
                {
                    
                    NSLog(@"Error:%@",error.localizedDescription);
                    
                }
                
                else
                    
                {
                    
                    NSLog(@"%@",myarray);
                    
                    _d1=[myarray valueForKey:@"weather"];
//                    _results=[myarray valueForKey:@"results"];
//                    
                    NSLog(@"The search results are:%@",_d1);
                    NSString *des=[_d1 valueForKey:@"description"];
                    NSLog(@"The description is:%@",des);
                   _Description.text= [NSString stringWithFormat:@"%@",des];
                   // NSString *u=[_d4 objectForKey:@"description"];
                   // _Description.text=u;
                   

                    _d2=[myarray valueForKey:@"main"];
                    id tmp=[_d2 valueForKey:@"temp"];
                     NSLog(@"The temprature is:%@",tmp);
                    _Temp.text=[NSString stringWithFormat:@"%@",tmp];
                    id hmd=[_d2 valueForKey:@"humidity"];
                    NSLog(@"The humidity is:%@",hmd);
                    _Humidity.text=[NSString stringWithFormat:@"%@",hmd];
//                    _country=[_results valueForKey:@"country"];
//                    
//                    NSLog(@"The countries are:%@",_country);
//                    
//                    _country=[_results valueForKey:@"isocode"];
//                    
//                    NSLog(@"The iso codes are:%@",_country);
                    
                }
                
                
                
                
                
            }
            
            else
                
            {
                
                NSLog(@"Data Not Found");
                
            }
            
        }
        
        else
            
        {
            
            NSLog(@"Response not Found");
            
        }
        
    }];
    
    [dataTask resume];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)tempa:(id)sender
//{
//    
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSString *u=[_d4 objectForKey:@"description"];
//    _Temp.text=u;
//    
//}

@end
