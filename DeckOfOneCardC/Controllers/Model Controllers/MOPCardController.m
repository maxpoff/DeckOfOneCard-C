//
//  MOPCardController.m
//  DeckOfOneCardC
//
//  Created by Maxwell Poffenbarger on 1/28/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

#import "MOPCardController.h"
#import "MOPCard.h"

@implementation MOPCardController

static NSString * const BaseURLString = @"https://deckofcardsapi.com/api/deck/new/";
static NSString * const DrawComponent = @"draw/";
static NSString * const CountQueryName = @"count";
static NSString * const CardsArray = @"cards";

+ (void)drawNewCard:(NSNumber *)numberOfCards completion:(void (^)(NSArray<MOPCard *> *_Nullable))completion
{
    NSURL * baseURL = [NSURL URLWithString:BaseURLString];
    NSURL * drawURL = [baseURL URLByAppendingPathComponent:DrawComponent];
    NSString *cardCount = [numberOfCards stringValue];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:drawURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:CountQueryName value:cardCount];
    urlComponents.queryItems = @[queryItem];
    NSURL *searchURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil); return;
        }
        
        if (!data)
        {
            NSLog(@"Error: no data");
            completion(nil); return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options: 2 error: &error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Unable to create dictionary from data");
            completion(nil); return;
        }
        
        NSArray * cardsArray = jsonDictionary[CardsArray];
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        for (NSDictionary *cardDictionary in cardsArray)
        {
            MOPCard *card = [[MOPCard alloc] initWithDictionary: cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        
        completion(cardsPlaceholder);
    }]resume];
}

+ (void)fetchCardImage:(MOPCard *)card completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.image];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil); return;
        }
        
        if (!data)
        {
            NSLog(@"Error: no data");
            completion(nil); return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage);
    }]resume];
}
@end
