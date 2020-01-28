//
//  MOPCardController.h
//  DeckOfOneCardC
//
//  Created by Maxwell Poffenbarger on 1/28/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MOPCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOPCardController : NSObject

+ (void)drawNewCard:(NSNumber *)numberOfCards completion:(void(^) (NSArray<MOPCard *> *_Nullable cards))completion;

+ (void)fetchCardImage:(MOPCard *)card completion:(void(^) (UIImage *_Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
