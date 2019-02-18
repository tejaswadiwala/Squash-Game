package;

import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.*;
import flixel.FlxBasic;

class PlayState extends FlxState
{
     private static inline var playerSpeed:Int = 400;

    private var player1:FlxSprite;
    private var player2:FlxSprite;
    private var ball:FlxSprite;
    private var topwall:FlxSprite;
    private var leftwall:FlxSprite;
    private var rightwall:FlxSprite;
    private var player1Score=0;
    private var player2Score=0;
    private var player1ScoreDisplay:FlxText;
    private var result:FlxText;
    private var player1Flag=1;
    private var player2Flag=0;
    private var maxScore=11;

    override public function create():Void
    {

        super.create();
        
        player1 = new FlxSprite(100,450);
        player1.makeGraphic(100,10,FlxColor.WHITE);
        player1.immovable=true;
        add(player1);

        player2 = new FlxSprite(440,450);
        player2.makeGraphic(100,10,FlxColor.RED);
        player2.immovable=true;
        add(player2);

        player1ScoreDisplay= new FlxText(30,40,"Player 1 0 \nPlayer 2 0 \n ");
        add(player1ScoreDisplay);

        ball=new flixel.FlxSprite(120,400);
        ball.makeGraphic(10,10,FlxColor.WHITE);
        ball.elasticity=1;
        ball.maxVelocity.set(10000,10000);
        ball.velocity.y=100;
        add(ball);

        topwall = new FlxSprite();
        topwall.makeGraphic(640,10,FlxColor.GRAY);//width, height, color
        topwall.immovable=true;
        add(topwall);

        leftwall = new FlxSprite();
        leftwall.makeGraphic(10,480,FlxColor.GRAY);
        leftwall.immovable=true;
        add(leftwall);

        rightwall = new FlxSprite(630,10);
        rightwall.makeGraphic(10,480,FlxColor.GRAY);
        rightwall.immovable = true;
        add(rightwall);

    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        player1.velocity.x=0;
        player2.velocity.x=0;
        if(FlxG.keys.anyPressed(["LEFT"]) && player1.x>10){
            player1.velocity.x = -playerSpeed;
        }
        if(FlxG.keys.anyPressed(["A"]) && player2.x>10){
            player2.velocity.x = -playerSpeed;
        }
        if(FlxG.keys.anyPressed(["RIGHT"]) && player1.x<540){
            player1.velocity.x = playerSpeed;
        }
        if(FlxG.keys.anyPressed(["D"]) && player2.x<540){
            player2.velocity.x = playerSpeed;
        }

        FlxG.collide(ball,leftwall);
        FlxG.collide(ball,rightwall);
        FlxG.collide(ball,topwall);

        if( player1Flag==1){
           if(FlxG.collide(ball,player1,Bam)){
            player1Flag=0;
            player2Flag=1;
            }
            else{
            if(ball.y>480){
                player2Score++;
                player1Flag=0;
                player2Flag=1;
                player1ScoreDisplay.text="Player 1 Score "+player1Score+"\nPlayer 2 Score "+player2Score;
                if(player2Score==maxScore){
                    player1ScoreDisplay.text="PLAYER 2 WON";
                    ball.velocity.set();
                    new FlxTimer().start(4,function(timer){FlxG.resetGame();});
                }
                resetBall(player2.x+player2.width/2,player2.y-50);
            }               
            }
        }
        
        if(player2Flag==1){
            if(FlxG.collide(ball,player2,Bam)){
            player1Flag=1;
            player2Flag=0;
            }
            else{
                if(ball.y>480){
                    player1Score++;
                    player1Flag=1;
                    player2Flag=0;
                    player1ScoreDisplay.text="Player 1 Score "+player1Score+"\nPlayer 2 Score "+player2Score;
                    if(player1Score==maxScore){
                        player1ScoreDisplay.text="PLAYER 1 WON";
                        ball.velocity.set();
                        new FlxTimer().start(4,function(timer){FlxG.resetGame();});
                    }
                    resetBall(player1.x+player1.width/2,player1.y-50);
            }               
            }
        }
        //FlxG.collide(ball,player2,Bam);

        //if(ball.y>480){
            //player1Score++;
            //player1ScoreDisplay.text="Player 1 Score "+player1Score;
            //resetBall();
        //}

    }

    private function Bam (Ball:FlxObject, Player:FlxObject){
        if(Ball.velocity.x>0 && Ball.velocity.y>0){
            Ball.velocity.x+=300;
            Ball.velocity.y+=300;
        }
        else {
            Ball.velocity.x-=125;
            Ball.velocity.y-=125;
        }

    }

    public function resetBall(xnew:Float,ynew:Float){
        ball.x=xnew;
        ball.y=ynew;
        ball.velocity.set();
        new FlxTimer().start(2, function(timer){
            ball.velocity.y=100;
        });
    }

    /*private function player1Serve(){
        ball=new flixel.FlxSprite(120,400);
        ball.makeGraphic(10,10,FlxColor.WHITE);
        ball.elasticity=1;
        ball.maxVelocity.set(10000,10000);
        ball.velocity.y=-100;
        add(ball);

    }*/
}