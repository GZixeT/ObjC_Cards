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
    GameStateCloseFirstCard = -1, // 0/2 карт открыто
    GameStateOneCardOpen, // 1/2 карт открыто
    GameStateTwoCardsOpen,
    GameStateEnd,
    GameStateError
}GameState;

@interface Cards : NSObject
@property NSMutableArray *map;
@property NSInteger firstCardOpen;
@property NSInteger secondCardOpen;
@property NSInteger height;
@property NSInteger cardDeckNumber;
@property GameState gameState;
+ (Cards*) sharedInstance;
- (id) init;
- (id) getMapElementWithIndext:(NSInteger)index;
- (BOOL) isGameEnd;
- (GameState) getGameState;
- (void)fillWithRandomCards;
- (void) shuffleMapElements;
- (void) setCards:(NSMutableArray*)array;
- (void) openCardWithIndex:(NSInteger)index :(BOOL)isOpen;
- (void) fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number;
- (void) setCapasityCardDeckWithHeight:(NSUInteger)height CardDeckNumber:(NSUInteger)number; //заполняем размер колоды, а не самой карты
@end
