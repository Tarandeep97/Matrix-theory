
#Helper Matrix for Addition,Find Multiple to make zero, Multiplication
Addition_Mat = [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0]
Identity_Mat = [0 0 0 0; 1 1 3 2; 2 2 1 3; 3 3 2 1]
Mul_Mat = [0 0 0 0; 0 1 2 3; 0 2 3 1; 0 3 1 2]


m = rand(2:5)
n = rand(2:5)

A = rand(0:3, (m, n))
b = rand(0:3, (m, 1))

Aug_Ab = hcat(A, b)


for i in 1:m-1
    #Partial Pivoting
    max_val, max_idx = findmax(Aug_Ab[i:m, i])
    if (max_idx!=1)
        (Aug_Ab[i, :], Aug_Ab[max_idx, :]) = (Aug_Ab[max_idx, :], Aug_Ab[i, :])
    end
    
    for j in i+1:m
        if (Aug_Ab[j,i]!=0)
            mul_tmp = Identity_Mat[Aug_Ab[j,i]+1, Aug_Ab[i,i]+1]
        end

        Aug_Ab[j,i]=0
        for k in i+1:n+1
            tmp = Addition_Mat[Aug_Ab[j, k]+1, Mul_Mat[mul_tmp+1, Aug_Ab[i, k]+1]+1]
            Aug_Ab[j, k] = tmp
        end
    end
end

Aug_Ab