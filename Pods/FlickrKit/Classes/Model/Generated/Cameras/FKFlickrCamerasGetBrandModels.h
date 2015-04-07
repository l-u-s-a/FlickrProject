//
//  FKFlickrCamerasGetBrandModels.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 19 Sep, 2014 at 10:49.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrCamerasGetBrandModelsError_BrandNotFound = 1,		 /* Unable to find the given brand ID. */
	FKFlickrCamerasGetBrandModelsError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrCamerasGetBrandModelsError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrCamerasGetBrandModelsError_WriteOperationFailed = 106,		 /* The requested operation failed due to a temporary issue. */
	FKFlickrCamerasGetBrandModelsError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrCamerasGetBrandModelsError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrCamerasGetBrandModelsError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrCamerasGetBrandModelsError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrCamerasGetBrandModelsError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrCamerasGetBrandModelsError;

/*

Retrieve all the models for a given camera brand.


Response:

<rsp stat="ok">
  <cameras brand="apple">
    <camera id="iphone_9000">
      <name>iPhone 9000</name>
      <details>
        <megapixels>22.0</megapixels>
        <zoom>3.0</zoom>
        <lcd_size>40.5</lcd_size>
        <storage_type>Flash</storage_type>
      </details>
      <images>
        <small>http://farm3.staticflickr.com/1234/cameras/123456_model_small_123456.jpg</small>
        <large>http://farm3.staticflickr.com/1234/cameras/123456_model_large_123456.jpg</large>
      </images>
    </camera>
  </cameras>
</rsp>

*/
@interface FKFlickrCamerasGetBrandModels : NSObject <FKFlickrAPIMethod>

/* The ID of the requested brand (as returned from flickr.cameras.getBrands). */
@property (nonatomic, copy) NSString *brand; /* (Required) */


@end
