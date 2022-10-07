using JLD2
@load "Samples_Prog_1.jld2"

#Helper Matrix for Addition,Find Multiple to make zero, Multiplication

Addition_Mat = [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0]
Identity_Mat = [0 0 0 0; 1 1 3 2; 2 2 1 3; 3 3 2 1]
Mul_Mat = [0 0 0 0; 0 1 2 3; 0 2 3 1; 0 3 1 2]

s_idx = 7

m = Samples[s_idx].m
n = Samples[s_idx].n

A = Samples[s_idx].A
b = Samples[s_idx].b

Aug_Ab = hcat(A, b)

fwd_steps = min(m,n)

l=1
i=1
while (i<=fwd_steps && l<=n)
    #Partial Pivoting
    max_val, max_idx = findmax(Aug_Ab[i:m, l])

    if (max_val==0)
        global l+=1
        continue
    end 

    if (max_idx!=1)
        (Aug_Ab[i, :], Aug_Ab[max_idx+i-1, :]) = (Aug_Ab[max_idx+i-1, :], Aug_Ab[i, :])
    end

    for j in i+1:m
        if (Aug_Ab[j,l]!=0)
            mul_tmp = Identity_Mat[Aug_Ab[j,l]+1, Aug_Ab[i,l]+1]

            Aug_Ab[j,l]=0
            for k in l+1:n+1
                tmp = Addition_Mat[Aug_Ab[j, k]+1, Mul_Mat[mul_tmp+1, Aug_Ab[i, k]+1]+1]
                Aug_Ab[j, k] = tmp
            end
        end
    end
    global i+=1
    global l+=1
end


Aug_Ab 
#Echelon form
U = Aug_Ab[:,1:n] 
U

#Find rank
l=1
i=1
rank_A=0
while (i<=fwd_steps)
    max_val, max_idx = findmax(Aug_Ab[i:m, l])
    if (max_val==0)
        global l+=1
        continue
    end
end



#Check consistency
if (rank==m)
    print("Consistent")
elseif(rank<m)


