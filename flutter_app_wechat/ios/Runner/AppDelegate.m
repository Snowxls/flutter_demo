#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@interface AppDelegate()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
}
@property (nonatomic,strong) FlutterMethodChannel *methodChannel;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    //拿到FlutterViewController
    FlutterViewController *vc = (FlutterViewController *)self.window.rootViewController;

    //显示线程
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"mine_page" binaryMessenger:vc];
    
    UIImagePickerController *imageVC = [UIImagePickerController new];
    imageVC.delegate = self;
    
    //监听Flutter的消息
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"picture"]) {
            ;
            [vc presentViewController:imageVC animated:YES completion:nil];
        }
    }];
 
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        NSString *imagePath = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        
        //将数据回传给 Flutter 中的 imagePath 方法
        [self.methodChannel invokeMethod:@"imagePath" arguments:imagePath];
    }];
}

@end
