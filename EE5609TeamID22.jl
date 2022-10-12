
function rankconsistencyTeamID22(A,b)
    m,n = size(A)

    #Helper Matrix for Addition,Find Multiple to make zero, Multiplication
    Addition_Mat = [0 1 2 3; 1 0 3 2; 2 3 0 1; 3 2 1 0]
    Identity_Mat = [0 0 0 0; 1 1 3 2; 2 2 1 3; 3 3 2 1]
    Mul_Mat = [0 0 0 0; 0 1 2 3; 0 2 3 1; 0 3 1 2]

    #Augmented Matrix
    Aug_Ab = hcat(A, b)
    fwd_steps = min(m,n)

    l=1
    i=1
    while (i<=fwd_steps && l<=n)
        #Partial Pivoting
        max_val, max_idx = findmax(Aug_Ab[i:m, l])

        if (max_val==0)
            l+=1
            continue
        end 

        if (max_idx!=1)
            (Aug_Ab[i, :], Aug_Ab[max_idx+i-1, :]) = (Aug_Ab[max_idx+i-1, :], Aug_Ab[i, :])
        end
        Aug_Ab_T = Aug_Ab'
        for j in i+1:m
            if (Aug_Ab[j,l]!=0)
                mul_tmp = Identity_Mat[Aug_Ab[j,l]+1, Aug_Ab[i,l]+1]

                Aug_Ab[j,l]=0
                Aug_Ab_T[l,j]=0
                for k in l+1:n+1
                    tmp = Addition_Mat[Aug_Ab_T[k,j]+1, Mul_Mat[mul_tmp+1, Aug_Ab_T[k,i]+1]+1]
                    Aug_Ab_T[k,j] = tmp
                end
            end
        end
        Aug_Ab = Aug_Ab_T'
        i+=1
        l+=1
    end

    U = Aug_Ab[:,1:n]
    
    #Find rank
    l=1
    i=1
    rank_A=0
    rank_Ab=0
    while (i<=fwd_steps && l<=n)
        if (Aug_Ab[i,l]!=0)
            rank_A+=1
            rank_Ab+=1
            i+=1
            l+=1
        else
            if (Aug_Ab[i,n+1]!=0)
                rank_Ab+=1
            end 
            l+=1
        end
    end

    #Check consistency
    consistent = false
    if (rank_A==rank_Ab)
        consistent=true
    end

    return U,rank_A,consistent
end

