#Q1a)
# Install tidyquant to get Mastercard stock data
install.packages("tidyquant")
library(tidyquant)

# Download historical stock data for Mastercard
ma_stock_data <- tq_get("MA",
                        from = "2012-01-01",
                        to = "2024-01-16",
                        get = "stock.prices")

# Save the data to a CSV file
write.csv(ma_stock_data, "MA_stock_data.csv", row.names = FALSE)

#Q1b)
# Install ggplot2 for visualization
install.packages("ggplot2")
library(ggplot2)

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
# Calculate the simple and continuously compounded returns
for (i in 2:nrow(ma_stock_data)) {
  simple_returns[i-1] <- (ma_stock_data$adjusted[i] - ma_stock_data$adjusted[i-1])/ma_stock_data$adjusted[i-1]
}

print(simple_returns)
