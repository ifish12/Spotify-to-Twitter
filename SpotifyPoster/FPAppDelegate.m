//
//  FPAppDelegate.m
//  SpotifyPoster
//
//  Created by Geoff Shapiro on 12-02-04.
//  Copyright (c) 2012 iFish Productions LLC. All rights reserved.
//

#import "FPAppDelegate.h"
#import "Spotify.h"
//  (:3[___])...sleepy...
@implementation FPAppDelegate
// (∩'ω'∩)
@synthesize window = _window;
// (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧*:･ﾟ✧
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
// ・゜・(ノД`)・゜・。
- (IBAction)pasteFromSpotifyToTwitter:(id)sender {
    SpotifyApplication *app = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    if (app) {
        SpotifyTrack *track = [app currentTrack];
        NSString *urlString = [NSString stringWithFormat:@"Now Playing: %@ - %@ - %@ - %@ on #Spotify",
                               track.name ? track.name : @"", track.artist, track.album, track.spotifyUrl];
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
//  ε=ε=ε=ε=ε=ε=┌(;￣◇￣)┘
@end
