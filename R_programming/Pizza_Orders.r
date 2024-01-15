pizza_chatbot <- function() {

    # Greeting
    user_name <- readline("Hello, what is your name? :" )
    message( paste("Welcome to pizza restaurant", user_name))
    message("Our menu includes many pizza toppings")

    # All menus
    menus_pizza <- data.frame(
        menu_id = c(1,2,3,4,5),
        pizza = c("[A] sausage", "[B] seafood", "[C] cheeze", "[D] hawaiian", "[E] pepperlony"),
        price = c(135, 199 , 120 , 150, 179)
        )

    View(menus_pizza)

    # Choose menus

    order_list <- list()
    amount_pizza <- list()
    price_orders <- list()
    total_price <- 0



    id <- 1
    while (id >= 1) {
        flush.console()
        order <- readline("Customer order: ")
        amount <- readline("Amount: ")
        order_list <- append(order_list, order)
        amount_pizza <- append(amount_pizza, amount)
        menu_list <- list(
                            Order = order_list,
                            Amount = amount_pizza
                         )

        if (order == "A") {
            total_price = total_price + (135 * as.numeric(amount))
        } else if (order == "B") {
            total_price = total_price + (199 * as.numeric(amount))
        } else if (order == "C") {
            total_price = total_price + (120 * as.numeric(amount))
        } else if (order == "D") {
            total_price = total_price + (150 * as.numeric(amount))
        } else if (order == "E") {
            total_price = total_price + (179 * as.numeric(amount))
        }

        message(paste("total price: ", total_price, " bath"))
        need_more <- readline("Would you like to order more food? (y/n): ")

            if (need_more == "n") {
                View(data.frame(menu_list))
                message("Thank you for supporting our pizza restaurant")
                message("You can pay by scan this qr code here")
                message("Wait minutes")
                break
            }
    }
}
