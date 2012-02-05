//
//  FPAppDelegate.m
//  SpotifyPoster
//
//  Created by Geoff Shapiro on 12-02-04.
//  Copyright (c) 2012 iFish Productions LLC. All rights reserved.
//

#import "FPAppDelegate.h"
#import "Spotify.h"

@implementation FPAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)pasteFromSpotifyToTwitter:(id)sender {
    SpotifyApplication *app = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    if (app) {
        SpotifyTrack *track = [app currentTrack];
        NSString *urlString = [NSString stringWithFormat:@"Now Playing: %@ - %@ - %@",
                               track.name ? track.name : @"", track.artist, track.album];
        NSString *encodedTrackName = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (__bridge CFStringRef)urlString,
                                                                                         NULL,
                                                                                         CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                         kCFStringEncodingUTF8);
        NSString *fullUrlString = [NSString stringWithFormat:@"Twitter://post?message=%@", encodedTrackName];
        NSURL *finalUrl = [NSURL URLWithString:fullUrlString];
        [[NSWorkspace sharedWorkspace] openURL:finalUrl];
//        NSLog(@"%@", [app currentTrack].name);
    } else  {
        NSLog(@"empty");
    }
}

@end
