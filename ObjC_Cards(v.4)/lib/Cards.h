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

typedef enum{
    TableOptionDisable,
    TableOptionEnable,
    TableOptionLock
}TableOption;

@interface Cards : NSObject
@property (readonly) NSMutableArray *map;
@property NSMutableArray *tableOfStates;
@property NSInteger height;
@property NSInteger cardDeckNumber;
+ (Cards*) sharedInstance;
+ (Cards*) sharedInstance:(NSUInteger)height CardDeckNumber:(NSUInteger)number;
- (id)initWithHeightAndDeckNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number;
- (BOOL) makeTaskWithCardAtIndex:(NSInteger)index :(BOOL)isOpen;
- (GameState) getGameState;
- (void) initTableOfStates;
- (void)fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number;
@end
