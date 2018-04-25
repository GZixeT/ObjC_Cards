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
        [self setFirstCardOpen:GameStateBegin];
        [self setSecondCardOpen:GameStateBegin];
        [self setGameState:GameStateBegin];
    }
    else NSLog(@"Ошибка инициализации");
    return self;
}
- (void) openCard:(NSInteger)index :(BOOL)isOpen{
    if(map!=nil){
        if(index<[[map getMap]count])
        {
            Card *card=[map getMapElementWithIndext:index];
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
        for(int i=0;i<[[map getMap]count];i++){
            Card *card=[map getMapElementWithIndext:i];
            if([card open]){
                count++;
            }
            else return false;
        }
        if(count==[[map getMap]count]){
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
- (void) setCards:(NSMutableArray *)array{
    if(map==nil){
        map=[[Map alloc]init];
        [map addArray:array];
        [map addArray:[self copyArray:array]];
        [map shuffleElements];
    }
    else NSLog(@"Карта уже заполнена");
}
@end
