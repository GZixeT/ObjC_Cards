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
@synthesize firstCardOpen;
@synthesize secondCardOpen;
@synthesize gameState;
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
    {
        map = [[NSMutableArray alloc]init];
        [self setFirstCardOpen:GameStateCloseFirstCard];
        [self setSecondCardOpen:GameStateCloseFirstCard];
        [self setGameState:GameStateCloseFirstCard];
    }
    else NSLog(@"Ошибка инициализации");
    return self;
}
- (id) getMapElementWithIndext:(NSInteger)index{
    return map?map[index]:false;
}
- (void) makeTaskWhithCardAtIndex:(NSInteger)index :(BOOL)isOpen{
    if(map){
        if(index<[map count] && [map count]!=0)
        {
            Card *card= map[index];
            [card setOpen:isOpen];
            if(isOpen){
                if(firstCardOpen<0)
                    firstCardOpen=index;
                else if (firstCardOpen!=index)
                    secondCardOpen= index;
                else NSLog(@"Такая карта уже открыта");
            }
        }
        else NSLog(@"Такой элемент не существует");
    }else NSLog(@"Карта еще несоздана");
}
- (GameState) getGameState{
    GameState state=GameStateError;
    if(firstCardOpen>0 && secondCardOpen>0)
    {
        [self isGameEnd];
        if(gameState==GameStateEnd)return gameState;
        return GameStateTwoCardsOpen;
    }
    else if(firstCardOpen>0 && secondCardOpen<0)return GameStateOneCardOpen;
    else if(firstCardOpen<0)return GameStateCloseFirstCard;
    return state;
}
- (BOOL) isGameEnd{
    if(map!=nil){
        int count=0;
        for(int i=0;i<[map count];i++){
            Card *card=map[i];
            if([card open]){
                count++;
            }
            else return false;
        }
        if(count==[map count]){
            gameState=GameStateEnd;
            return true;
        }
    }else NSLog(@"Карта еще несоздана");
    return false;
}
- (NSMutableArray*) copyArray:(NSMutableArray*)array{
    NSMutableArray *copy=[[NSMutableArray alloc]init];
    for(int i=0;i<[array count];i++){
        id tmp=[array objectAtIndex:i];
        [copy addObject:[tmp copy]];
    }
    return copy;
}
- (void) shuffleMapElements{
    if(map!=nil){
        int index=0;
        id tmp;
        for(int i=0;i<[map count];i++){
            index= (int)(arc4random() % (int) ([map count]-i) + i);
            tmp=map[i];
            [map replaceObjectAtIndex:i withObject:map[index]];
            [map replaceObjectAtIndex:index withObject:tmp];
        }
    }
    else NSLog(@"Карта еще не создана");
}
- (void) setCards{
    if(map){
        for (int i = 0; i < cardDeckNumber; i++) {
            {
                Card *randomCacrd = [Card createRandomCard];
                for (int j = 0; j < 2; j++) {
                    map[i*2+j] = [randomCacrd copy];
                }
            }
            
        }
        [self shuffleMapElements];
    }
    else NSLog(@"Карта уже заполнена");
}
- (void)setCapasityCardDeckWithHeight:(NSUInteger)height CardDeckNumber:(NSUInteger)number
{
    [self setHeight:height];
    [self setCardDeckNumber:number];
}
- (void)fillWithRandomCards
{
    [self setCards];
}
- (void)fillWithRandomCardsWithHeightAndNumber:(NSUInteger)height CardDeckNumber:(NSUInteger)number
{
    [self setCapasityCardDeckWithHeight:height CardDeckNumber:number];
    [self fillWithRandomCards];
}
@end
