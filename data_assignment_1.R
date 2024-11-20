# Install packages
install.packages("tidyquant")
library(tidyquant)
install.packages("ggplot2")
library(ggplot2)

#Q1a)
# Download historical stock data for Mastercard
ma_stock_data <- tq_get("MA",
                        from = "2012-01-01",
                        to = "2024-01-16",
                        get = "stock.prices")


#Q1b)
# Plot the Adjusted Closing Price over time
ggplot(ma_stock_data, aes(x = date, y = adjusted)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Mastercard Stock Price",
    x = "Date",
    y = "Adjusted closing price ($)"
  ) +
  theme_minimal()

#Q1c) and d)
# Initialize a vector for simple and continuous returns
simple_returns <- numeric(nrow(ma_stock_data) - 1)
continuous_returns <- numeric(nrow(ma_stock_data) - 1)

# Calculate the simple and continuously compounded returns and add them to the vector
for (i in 2:nrow(ma_stock_data)) {
  simple_returns[i-1] <- (ma_stock_data$adjusted[i] - ma_stock_data$adjusted[i-1])/ma_stock_data$adjusted[i-1]
  continuous_returns[i-1] <- log(ma_stock_data$adjusted[i]/ma_stock_data$adjusted[i-1])
}

# Square the simple compounded returns
simple_returns_squared <- simple_returns^2

# Add simple and continuously compounded returns to the dataframe
ma_stock_data$simple_returns <- c(0, simple_returns)
ma_stock_data$continuous_returns <- c(0, continuous_returns)
ma_stock_data$simple_returns_squared <- c(0, simple_returns_squared)


#Plot simple compounded returns 
ggplot(ma_stock_data, aes(x = date, y = simple_returns)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Simple Compounded Returns from Mastercard",
    x = "Date",
    y = "Simple compounded returns"
  ) +
  theme_minimal()

#Plot continuously compounded returns 
ggplot(ma_stock_data, aes(x = date, y = continuous_returns )) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Continuously Compounded Returns from Mastercard",
    x = "Date",
    y = "Continuously compounded returns"
  ) +
  theme_minimal()

# Create the ACF of the simple returns squared with 50 lags
acf(ma_stock_data$simple_returns_squared, lag = 50, main = "ACF of Simple Compounded Returns Squared")

#Q1e)
# Perform a Ljung-Box Test with 10 and 20 lags
Box.test(ma_stock_data$simple_returns_squared, lag = 10, type = c("Ljung-Box"))
Box.test(ma_stock_data$simple_returns_squared, lag = 20, type = c("Ljung-Box"))

#Q1f)
# Making a QQ-plot for the simple compounded returns
qqnorm(ma_stock_data$simple_returns,
       main = "QQ-plot of simple returns", 
       xlab = "Theoretical Quantiles", 
       ylab = "Data Quantiles"
       )
qqline(ma_stock_data$simple_returns, col="red")
