# create a vector. c - combine
apple <- c('red', 'green', 'yellow')
print(apple)
print(class(apple))

# create a matrix. by row是否按行输入 矩阵限制维度为2维
M = matrix(c('a', 'b', 'c', 'd', 'e', 'e'), nrow = 2, ncol = 3, byrow = TRUE)
print(M)

# create am array. 阵列可以具有任何数量的维度
a <- array(c('green', 'yellow'), dim = (c(3, 3, 2)))
print(a)

# create a vector.
apple_colors <- c('green', 'green', 'yellow', 'red', )
# create a factor object.
factor_apple <- factor(apple_colors)
# print the factor
