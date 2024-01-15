user_score <- 0
comp_score <- 0

game <- function() {

    user_name <- readline("Hi! what is your name? : ")
    message( paste("Welcome to Rock Paper Scissors Game 🔨✂️📰 , ", user_name))
    message( "Alright, let's compete." )
    message("This game has 3 weapons for you to choose from: hammer🔨, paper📰, and scissors✂️.")
    message("If you want to stop playing, Type the word: stop.")
    message("Let's play now")

    while ( user_score < 4 & comp_score < 4 ) {
        flush.console()
        hands <- c("hammer", "scissor", "paper")
        comp_hand <- sample(hands, 1)
        user_hand <- readline("Choose your hand: ")

            if (user_hand == "stop") {
                break
            }

            if (user_hand == comp_hand ) {
                message("draw!! keep trying 🤪")
                message( paste("Your score 👨🏻: ", user_score))
                message( paste("Comp score 🤖: ", comp_score))
            }


            if (user_hand != comp_hand ) {
                if ( user_hand == "hammer" & comp_hand == "scissor") {
                    user_score <- user_score + 1
                    message( "You Win! 🥇" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                } else if (user_hand == "hammer" & comp_hand == "paper") {
                    comp_score <- comp_score + 1
                    message( "You Lose! 😏" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                } else if ( user_hand == "scissor" & comp_hand == "paper") {
                    user_score <- user_score + 1
                    message( "You Win! 🥇" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                } else if ( user_hand == "scissor" & comp_hand == "hammer") {
                    comp_score <- comp_score + 1
                    message( "You Lose! 😏" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                } else if ( user_hand == "paper" & comp_hand == "hammer") {
                    user_score <- user_score + 1
                    message( "You Win! 🥇" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                } else if ( user_hand == "paper" & comp_hand == "scissor") {
                    comp_score <- comp_score + 1
                    message( "You Lose! 😏" )
                    message( paste("Your score 👨🏻: ", user_score))
                    message( paste("Comp score 🤖: ", comp_score))
                }
            }
    }
    if ( user_score == 4 ) {
        return( "Congratulations, you won me 🎊" )
    } else if ( comp_score == 4 ) {
        return("Nice try, let's play again👍")
    }
}
