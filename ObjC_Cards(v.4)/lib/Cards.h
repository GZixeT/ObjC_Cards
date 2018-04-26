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
    GameStateBegin=-1,
    GameStateCloseFirstCard = -1, // 0/2 карт открыто
    GameStateOneCardOpen, // 1/2 карт открыто
    GameStateTwoCardsOpen,
    GameStateEnd,
    GameStateError
}GameState;

@interface Cards : NSObject
@property Map *map;
@property NSInteger firstCardOpen;
@property NSInteger secondCardOpen;
@property GameState gameState;
+ (Cards*) sharedInstance;
- (id) init;
- (void) openCard:(NSInteger)index :(BOOL)isOpen;
- (BOOL) isGameEnd;
- (void) setCards:(NSMutableArray*)array;
- (GameState) getGameState;
- (void)fillWithRandomCardsWithCapasityHeight:(NSUInteger)height Widht:(NSUInteger)wight;
- (void)setCapasityWithHeight:(NSUInteger)height Widht:(NSUInteger)wight;
- (void)fillWithRandomCards;
- (NSUInteger)getCapasity;
@end
