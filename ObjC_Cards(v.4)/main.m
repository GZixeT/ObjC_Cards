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

#define HEIGHT 3
#define CARD_DECK_NUMBER 3
#define GAME_START 1
#define GAME_OPEN_CARD 2

typedef enum{
    GameMenuBegin=1,
    GameMenuOpenCard,
    GameMenuExit=10
} GameMenu;

typedef enum{
    GameTypeWithTable=1,
    GameTypeWithFirstCard
}GameType;



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        GameConsoleInterface *interface=[[GameConsoleInterface alloc]init];
        Cards *cards=[Cards sharedInstance:HEIGHT CardDeckNumber:CARD_DECK_NUMBER];
        switch (GAME_START)
        {
            case GameTypeWithTable:
                [interface printCards];
                while(true){
                    switch(GAME_OPEN_CARD){
                        case GameMenuOpenCard:
                        {
                            int index=0;
                            printf("Введите номер карты:");
                            scanf("%d",&index);
                            if([cards makeTaskWithCardAtIndex:index :true])
                            {
                                [interface printCards];
                                //NSLog(@"%d",[cards getGameState:index]);
                                switch([cards getGameState])
                                {
                                    case GameStateFalse:
                                        [interface printCards];
                                        break;
                                    case GameStateEnd:
                                        printf("Победа!\n");
                                        return 0;
                                        break;
                                    case GameStateError:
                                        printf("Error.\n");
                                        break;
                                    case GameStateTrue:
                                        break;
                                    default:
                                        printf("Error.\n");
                                        break;
                                    }
                                }//if open==true
                            }break;//GameMenuOpenCard
                            case GameMenuExit:
                                return 0; // exit game cicle
                            default:
                                printf("Error.\n");
                                break;
                        }//menu switcher table
                    };break;
            default:
                printf("Ошибка\n");
                break;
        }//game type switcher
    }
    return 0;
}
