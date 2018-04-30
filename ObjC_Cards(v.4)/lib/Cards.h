//
//  Cards.h
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "Card.h"
typedef enum{
    GameStateTrue =1,
    GameStateFalse,
    GameStateEnd,
    GameStateError
}GameState;

@interface Cards : NSObject
@property (readonly) NSMutableArray *map;
@property NSInteger firstCard;
@property NSInteger height;
@property NSInteger cardDeckNumber;
+ (Cards*) sharedInstance;
- (id) init;
- (GameState) getGameState:(NSInteger)index;
- (BOOL) makeTaskWhithCardAtIndex:(NSInteger)index :(BOOL)isOpen;
- (void) fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number;
@end
