# PROBLEM ONE

set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

# remove na's
hw2 <- hw2[!is.na(hw2)]
hw2

# subset data between 14 and 38 inclusive

prob1 <- hw2[hw2>=14 & hw2<=38]
prob1

# PROBLEM TWO
time3 <- prob1*3
time3
plus10 <- time3+10
plus10

# PROBLEM THREE: select every other

final <- plus10[c(TRUE,FALSE)]
final
