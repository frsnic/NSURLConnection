//
//  ViewController.m
//  onebtnonelable
//
//  Created by test on 2/25/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSMutableData *receivedData;
    NSURLConnection *theConnection;
}
@synthesize button;
@synthesize post_btn;
@synthesize nxtext;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)cllickbtn:(id)sender {

    nxtext.text = @"";
    
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:
                               [NSURL URLWithString:@"http://www.googleapis.com/"]
                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    receivedData = [[NSMutableData alloc] init];
    
    // create the connection with the request
    // and start loading the data
    theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (!theConnection) {
        // Release the receivedData object.
        receivedData = nil;
        
        // Inform the user that the connection failed.
    }

}
- (IBAction)post_click:(id)sender {
    
    nxtext.text = @"";

    // In body data for the 'application/x-www-form-urlencoded' content type,
    // form fields are separated by an ampersand. Note the absence of a
    // leading ampersand.
    NSString *bodyData = @"name=Jane+Doe&address=123+Main+St";
    
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.googleapis.com/"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    receivedData = [[NSMutableData alloc] init];
    
    // Initialize the NSURLConnection and proceed as described in
    // Retrieving the Contents of a URL
    [NSURLConnection connectionWithRequest:postRequest delegate:self];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
    NSLog(@"connection didReceiveData");
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    theConnection = nil;
    receivedData = nil;
    
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a property elsewhere
    NSLog(@"Received %d bytes of data",[receivedData length]);
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    
    NSString *responseData;
    responseData = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    NSLog(@"%@", responseData);

    nxtext.text = responseData;
    
    theConnection = nil;
    receivedData = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSLog(@"didReceiveMemoryWarning");
}

@end
