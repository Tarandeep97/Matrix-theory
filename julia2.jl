# # Executing Code in REPL 

# Change Julia extension settings in VSCode
# Execution: Code in REPL ---> Enable this

# # Scalars & Types # # 

# Numbers
a = 2
typeof(a)

b = 2.45
typeof(b)

c = a+b
typeof(c)

c = complex(4,3)
typeof(c)

c = complex(4.0,3.0)
c = 4.0 + 3.0im
typeof(c)

# Bool
flag1 = false
typeof(flag1)

flag1 = typeof(a) == Int64
flag2 = (3 == 3.0)
flag3 = (π == 22/7)

# # Control Statements # # 

# if-else
a = rand() - 0.5
b = rand() - 0.5
if (a^2 + b^2) ≤ 1
    print("Inside the circle")
else
    print("Outside the circle")
end

# compact if-else
(a^2 + b^2) ≤ 1 ? print("Inside") : print("outside")


# for loop
s = 0
for i ∈ 1:10
    global s += i^2
end
print("sum of squares =", s)

# while loop
s = 0
i = 10
while i ≥ 1
    global s += i^2
    global i -= 1
end
print(s)

# break 
while true
    b = rand(1:4)
    print(b)
    b == 1 ? break : print(",")
end

# scope of variables
i = 5
for i ∈ 1:3
    println("i inside the loop is ",i)
end
println("i outside the loop is ",i)

# # Vectors # # 

# Initializing vectors
x = 1:10
y = collect(1:10)
sizeof(x)
sizeof(y)
typeof(x)
typeof(y)

x = collect(1.0:1.0:10.0)
x = randn(10)
x = ["My Name", 2.0, 2//3, rand(3)]

# Accesing vector entries
x[2]
x[end]
x[2:2:end]

# Assignment vs copy
x = collect(1:5)
y = x
y[1] = 100
print(y)
display(x)
x == y
x === y

z = copy(x)
z === x
z == x
z[2]=-99 
z .== x

a = 2
b = a
b = 3
print(a)

# Initializing without assigning values
x = Array{Float64,1}(undef,5)
x = Array{Bool,1}(undef,10)

# Operations on Vectors 
x = collect(1:5)
sum(x)
sum(x.^2)
y = collect(6:10)
x + y
x + 1
x .+ 1
2x
x^2 + 2x + 1
x^2 + 2x .+ 1
x.^2 + 2x .+ 1
@. x^2 + 2x + 1

# # functions 

# function definitions and return values
function myfun1(x)
    return x^2
end

function myfun2(x)
    x^2
end

myfun3(x) = x^2 + log(x)

x = collect(1:10)
y = map(a -> myfun3(a),x)

# functions returning nothing
function myfun(x)
    display(x)
    return nothing
end 

# multiple arguments and return values
function myfun4(a,b)
    if a^2 + b^2 ≤ 1
        return "Inside"
    else
        return "Outside"
    end
end
print(myfun4(0.24,0.35))

function myfun5(a,b)
    if a^2 + b^2 ≤ 1
        answer = "Inside"
    else
        answer = "Outside"
    end
    return answer, abs(complex(a,b))
end
answer, abs_value = myfun5(1.2,-3.0)
fun_out = myfun5(1.2,-3.0)

# functions with array arguments
function replace_with_max(x)
    n = length(x)
    max_val = x[1]
    for i in 2:n
        max_val = max(max_val,x[i])
    end

    for i in eachindex(x)
        x[i] = max_val
    end

    return x
end

x = collect(1:4)
y = replace_with_max(x)
display(x)

# Julia convention: functions that modify arguments 
function myfun6(x)
    x[1:1:end] = x[end:-1:1]
    return nothing
end
x = collect(1:3)
myfun6(x)
display(x)

# # Matrices

# Initialization
A = [1 2 3; 4 5 6]
A = [1.0 2 3; 4 5 6]
A = randn(2,3)
A = zeros(2,3)
A = ones(2,3)
A = Matrix{Float64}(I,3,3)
A = Matrix{Float64}(undef, (2,3))

# Indexing
A = [1 2 3; 4 5 6]
A[2,3]
A[5]
A[2,:]
A[:,3]
A = rand(5,5)
A[1:2,1:2]

# Row operations
A[1,:] = A[1,:]*100
A[2,:] = A[2,:] + A[1,:]
(A[1,:],A[5,:]) = (A[5,:],A[1,:])

# Matrix operations
A = rand(2,3)
B = rand(3,4)
C = A*B

# Transforming using matrix operations
function myfun7(x,θ)
    A = [cos(θ) -sin(θ); sin(θ) cos(θ)];
    return A*x
end

# # Multiple Dispatch
function myfun8(x::Vector{<:Number},y::Matrix{<:Number})
    return y*x
end

function myfun8(x::Matrix{<:Number},y::Vector{<:Number})
    return x*y
end

function myfun8(x::Vector{<:Number},y::Vector{<:Number})
    return sum(x.*y)
end

myfun8([1,2,3],[0 1 0; 1 0 0; 0 0 0])
myfun8([1,-1,-1],[2,3,4])
myfun8([0 0 1; 0 1 0; 1 0 0],[1,2,3])
