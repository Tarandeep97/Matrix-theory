
#Helper Matrix for Addition,Find Multiple to make zero, Multiplication

Addition_Mat = [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0]
Identity_Mat = [0 0 0 0; 1 1 3 2; 2 2 1 3; 3 3 2 1]
Mul_Mat = [0 0 0 0; 0 1 2 3; 0 2 3 1; 0 3 1 2]


m = rand(2:7)
n = rand(2:7)

A = rand(0:3, (m, n))
b = rand(0:3, (m, 1))

Aug_Ab = hcat(A, b)

fwd_steps = min(m,n)

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
            for k in i+1:n+1
                tmp = Addition_Mat[Aug_Ab[j, k]+1, Mul_Mat[mul_tmp+1, Aug_Ab[i, k]+1]+1]
                Aug_Ab[j, k] = tmp
            end
        end
    end
end


Aug_Ab 
#Echelon form
U = Aug_Ab[:,1:n] 
U

#Find rank
rank_A=0
for i in 1:fwd_steps
    if (Aug_Ab[i,i]!=0)
        global rank+=1
    end
end



#Check consistency
if (rank==m)
    print("Consistent")
elseif(rank<m)


