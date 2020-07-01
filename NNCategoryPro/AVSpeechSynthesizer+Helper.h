//
//  AVSpeechSynthesizer+Helper.h
//  AVFoundation-语音朗读
//
//  Created by Bin Shang on 2019/3/20.
//  Copyright © 2019 Frank.Zhang. All rights reserved.
//

//#import <AVFAudio/AVFAudio.h>
#import <AVFoundation/AVFoundation.h>

@interface AVSpeechSynthesizer (Helper)

AVSpeechUtterance * AVSpeechUtteranceParam(NSString *speechString,
                                           NSString *voiceLanguage,
                                           float rate,
                                           float volume,
                                           float pitchMultiplier,
                                           NSTimeInterval preUtteranceDelay,
                                           NSTimeInterval postUtteranceDelay);

AVSpeechUtterance * AVSpeechUtteranceDefault(NSString *speechString, NSString *voiceLanguage);

@end

