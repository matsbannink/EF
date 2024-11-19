#Q1a)
install.packages("tidyquant")
library(tidyquant)

# Download historical stock data for Mastercard
ma_stock_data <- tq_get("MA",
                        from = "2012-01-01",
                        to = "2024-01-16",
                        get = "stock.prices")

# Save the data to a CSV file (optional)
write.csv(ma_stock_data, "MA_stock_data.csv", row.names = FALSE)

#Q1b)
# Load ggplot2 for visualization
library(ggplot2)

# Plot the Adjusted Closing Price over time
ggplot(ma_stock_data, aes(x = date, y = adjusted)) +
  geom_line(color = "blue", size = 1) +
  labs(
    title = "Mastercard stock price over time",
    x = "Date",
    y = "Adjusted closing price"
  ) +
  theme_minimal()

#Q1c)
#test