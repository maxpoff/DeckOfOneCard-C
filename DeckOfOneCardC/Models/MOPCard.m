//
//  MOPCard.m
//  DeckOfOneCardC
//
//  Created by Maxwell Poffenbarger on 1/28/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import "MOPCard.h"

@implementation MOPCard

NSString * suitKey = @"suit";

NSString * imageKey = @"image";

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _suit = [suit copy];
        _image = [image copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[suitKey];
    NSString *image = dictionary[imageKey];
    
    return [self initWithSuit:suit image:image];
}

@end

