#Q1a)
# Install tidyquant to get Mastercard stock data
install.packages("tidyquant")
library(tidyquant)
install.packages("ggplot2")
library(ggplot2)

# Download historical stock data for Mastercard
ma_stock_data <- tq_get("MA",
                        from = "2012-01-01",
                        to = "2024-01-16",
                        get = "stock.prices")

#Q1b)
# Install ggplot2 for visualization


# Plot the Adjusted Closing Price over time
ggplot(ma_stock_data, aes(x = date, y = adjusted)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Mastercard Stock Price",
    x = "Date",
    y = "Adjusted closing price ($)"
  ) +
  theme_minimal()

#Q1c)
# Initialize a vector for simple returns
simple_returns <- numeric(nrow(ma_stock_data) - 1)
continuous_returns <- numeric(nrow(ma_stock_data) - 1)

# Calculate the simple and continuously compounded returns
for (i in 2:nrow(ma_stock_data)) {
  simple_returns[i-1] <- (ma_stock_data$adjusted[i] - ma_stock_data$adjusted[i-1])/ma_stock_data$adjusted[i-1]
  continuous_returns[i-1] <- log(ma_stock_data$adjusted[i]/ma_stock_data$adjusted[i-1])
}

ma_stock_data$simple_returns <- c(0, simple_returns)
ma_stock_data$continuous_returns <- c(0, continuous_returns)

#PLot simple returns 
ggplot(ma_stock_data, aes(x = date, y = simple_returns)) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Simple Compounded Returns",
    x = "Date",
    y = "Simple compounded returns "
  ) +
  theme_minimal()

#Plot continuous returns 
ggplot(ma_stock_data, aes(x = date, y = continuous_returns )) +
  geom_line(color = "blue", linewidth = 1) +
  labs(
    title = "Continuously Compounded Returns ",
    x = "Date",
    y = "Continuously compounded returns "
  ) +
  theme_minimal()

