
#Helper Matrix for Addition,Find Multiple to make zero, Multiplication

Addition_Mat = [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0]
Identity_Mat = [0 0 0 0; 1 1 3 2; 2 2 1 3; 3 3 2 1]
Mul_Mat = [0 0 0 0; 0 1 2 3; 0 2 3 1; 0 3 1 2]


m = rand(2:7)
n = rand(2:7)

A = rand(0:3, (m, n))
b = rand(0:3, (m, 1))

Aug_Ab = hcat(A, b)

fwd_steps = min(m,n)-1
all_zero_rows = Vector{Int64}()

for i in 1:fwd_steps
    #Partial Pivoting
    max_val, max_idx = findmax(Aug_Ab[i:m, i])
    if (max_idx!=1)
        (Aug_Ab[i, :], Aug_Ab[max_idx+i-1, :]) = (Aug_Ab[max_idx+i-1, :], Aug_Ab[i, :])
    end

    
    for j in i+1:m
        if (Aug_Ab[j,i]!=0)
            mul_tmp = Identity_Mat[Aug_Ab[j,i]+1, Aug_Ab[i,i]+1]

            Aug_Ab[j,i]=0
            zero_row_f = true
            for k in i+1:n+1
                tmp = Addition_Mat[Aug_Ab[j, k]+1, Mul_Mat[mul_tmp+1, Aug_Ab[i, k]+1]+1]
                if (tmp!=0)
                    zero_row_f=false
                end
                Aug_Ab[j, k] = tmp
            end

            if (zero_row_f==true)
                append!(all_zero_rows,j-i+1) #Fix needed here
            end
        end
    end
end

Aug_Ab
all_zero_rows