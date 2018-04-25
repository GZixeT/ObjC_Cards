//
//  main.m
//  ObjC_Cards(v.3)
//
//  Created by Георгий Зубков on 19.04.2018.
//  Copyright © 2018 Георгий Зубков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConsoleInterface.h"
#import "Card.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        GameConsoleInterface *interface=[[GameConsoleInterface alloc]init];
        Cards *cards=[[Cards alloc]init];
        NSMutableArray *array = [[Card alloc]getRandomArray:6];
        [cards setCards:[array copy]];
        [[cards map]setWidth:3];
        [[cards map]setHeight:3];
        int k=10;
        do{
            printf("1.Начать игру.\n");
            printf("2.Открыть карту.\n");
            printf("10.Выход.\n");
            printf("Введите номер действия:");
            scanf("%d",&k);
            switch(k){
                case 1:{
                    [interface printCards:cards];
                }break;
                case 2:{
                    int number=0;
                    printf("Введите номер карты:");
                    scanf("%d",&number);
                    [cards openCard:number :true];
                    [interface printCards:cards];
                    switch([cards getGameState]){
                        case GameStateTwoCardsOpen:{
                            Card *first=[[cards map]getMapElementWithIndext:[cards firstCardOpen]];
                            Card *second=[[cards map]getMapElementWithIndext:[cards secondCardOpen]];
                            if(![first isEqual:second]){
                                [cards openCard:[cards firstCardOpen] :false];
                                [cards openCard:[cards secondCardOpen] :false];
                                [interface printCards:cards];
                            }
                            [cards setFirstCardOpen:GameStateCloseFirstCard];
                            [cards setSecondCardOpen:GameStateCloseFirstCard];
                        }break;
                        case GameStateEnd:
                            printf("Победа!\n");
                            break;
                        case GameStateError:
                            printf("Error.\n");
                    }
                }break;
            }
        }while(k!=10);
    }
    return 0;
}
