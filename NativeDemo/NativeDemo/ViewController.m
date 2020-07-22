//
//  ViewController.m
//  NativeDemo
//
//  Created by Snow WarLock on 2020/6/22.
//  Copyright © 2020 Snowxls. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

/*
FlutterMethodChannel; //调用方法（method invocation） 一次通讯
FlutterBasicMessageChannel; //传递字符&半结构化信息  持续通讯
FlutterEventChannel; //用于数据流（stream）通讯  持续通讯
 */

@interface ViewController () {
    
}

@property (nonatomic,strong) FlutterEngine *flutterEngine;
@property (nonatomic,strong) FlutterViewController *flutterVC1;
@property (nonatomic,strong) FlutterViewController *flutterVC2;
@property (nonatomic,strong) FlutterBasicMessageChannel *msgChannel;
@end

@implementation ViewController

- (FlutterEngine *)flutterEngine {
    if (!_flutterEngine) {
        FlutterEngine *engine = [[FlutterEngine alloc] initWithName:@"Snow"];
        if (engine.run) {
            //运行引擎 提前启动防止卡顿
            _flutterEngine = engine;
        }
       
    }
    return _flutterEngine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flutterVC1 = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
    self.flutterVC1.modalPresentationStyle = UIModalPresentationFullScreen;
//    self.flutterVC2 = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
//    self.flutterVC2.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [btn1 setTitle:@"pushFlutter1" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    btn1.center = self.view.center;
    [btn1 addTarget:self action:@selector(pushFlutter1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.frame.origin.x, btn1.frame.origin.y+50+10, 200, 50)];
    [btn2 setTitle:@"pushFlutter2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(pushFlutter2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //接收Flutter数据
    self.msgChannel = [FlutterBasicMessageChannel messageChannelWithName:@"messageChannel" binaryMessenger:self.flutterVC1];
    [self.msgChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSLog(@"收到Flutter的:%@",message);
    }];
}

- (void)pushFlutter1:(UIButton *)btn {
    FlutterMethodChannel * methodChannel = [FlutterMethodChannel methodChannelWithName:@"one_page" binaryMessenger:self.flutterVC1];
    [methodChannel invokeMethod:@"one" arguments:nil];
    
    [self presentViewController:self.flutterVC1 animated:YES completion:nil];
    
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC1 dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}


- (void)pushFlutter2:(UIButton *)btn {
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"two_page" binaryMessenger:self.flutterVC2];
    [methodChannel invokeMethod:@"two" arguments:nil];
    
    [self presentViewController:self.flutterVC2 animated:YES completion:nil];
    
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"exit"]) {
            [self.flutterVC2 dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int a = 0;
    [self.msgChannel sendMessage:[NSString stringWithFormat:@"%d",a++]];
}

@end
