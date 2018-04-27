//
//  Cards.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

//Проба коммита 2
#import "Cards.h"

static Cards *uniqueInstance=nil;
@implementation Cards
@synthesize map;
@synthesize cardDeckNumber;
@synthesize height;
+ (Cards*) sharedInstance{
    @synchronized(self)
    {
        if(uniqueInstance==nil)
            uniqueInstance=[[self alloc]init];
    }
    return uniqueInstance;
}
- (id) init{
    if(self=[super init])
        map = [[NSMutableArray alloc]init];
    else NSLog(@"Ошибка инициализации");
    return self;
}
- (void) makeTaskWhithCardAtIndex:(NSInteger)index :(BOOL)isOpen
{
    if(index<[map count] && [map count]!=0)
    {
        Card *card= map[index];
        [card setOpen:isOpen];
    }
    else NSLog(@"Такой элемент не существует");
}
- (NSMutableArray*) getOpenCards{
    NSMutableArray *openCards= [[NSMutableArray alloc]init];
    for(int i=0;i<[map count];i++){
        Card *card=[map objectAtIndex:i];
        if([card open])
            [openCards addObject:[NSNumber numberWithInteger:i]];
    }
    return openCards;
}
- (GameState) getGameState{
    GameState state=GameStateError;
    NSMutableArray *openCards=[self getOpenCards];
    switch([openCards count])
    {
        case GameStateNoOneCardIsOpen:
            state=GameStateNoOneCardIsOpen;
            break;
        case GameStateOneCardIsOpen:
            state=GameStateOneCardIsOpen;
            break;
        default:
            if([openCards count]==[map count])
                state=GameStateEnd;
            else state=GameStateManyCardsIsOpen;
            break;
    }
    return state;
}
- (NSMutableArray*) copyArray:(NSMutableArray*)array
{
    NSMutableArray *copy=[[NSMutableArray alloc]init];
    for(int i=0;i<[array count];i++)
    {
        id tmp=[array objectAtIndex:i];
        [copy addObject:[tmp copy]];
    }
    return copy;
}
- (void) shuffleMapElements{ //private
    int index=0;
    id tmp;
    for(int i=0;i<[map count];i++)
    {
        index= (int)(arc4random() % (int) ([map count]-i) + i);
        tmp=map[i];
        [map replaceObjectAtIndex:i withObject:map[index]];
        [map replaceObjectAtIndex:index withObject:tmp];
    }
}
- (void) fillWithRandomCards{ //private
    for (int i = 0; i < cardDeckNumber; i++)
    {
        Card *randomCacrd = [Card createRandomCard];
        for (int j = 0; j < 2; j++)
            map[i*2+j] = [randomCacrd copy];
    }
    [self shuffleMapElements];
}
- (void)fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number
{
    [self setHeight:height];
    [self setCardDeckNumber:number];
    [self fillWithRandomCards];
}
@end
