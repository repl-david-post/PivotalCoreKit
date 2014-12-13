#import "InterfaceController.h"


@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;
@property (weak, nonatomic) IBOutlet WKInterfaceSeparator *separator;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *actionButton;
@property (weak, nonatomic) IBOutlet WKInterfaceDate *date;
@property (weak, nonatomic) IBOutlet WKInterfaceSwitch *theSwitch;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *noActionButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *seguePushButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *segueModalButton;
@property (nonatomic) NSMutableString* context;

@end


@implementation InterfaceController

#pragma mark - WKInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    self.context = context;
}

- (void)willActivate
{
    [self.titleLabel setText:@"My Special Text"];
}

- (void)didDeactivate
{
    self.actionButton.enabled = NO;
    self.theSwitch.enabled = NO;
    self.theSwitch.on = NO;
}

- (IBAction)didTapButton
{
    [self.context appendString:@"Tweet."];
}

@end



