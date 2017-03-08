main {
	loop
		if (2 < i) then
			break; 
		fi
		loop
			if (2 < j) then
				break; # break to the outer loop 
			fi
			if (b[j] < a[i]) then
				break 2; # break out of two loops
			fi
			j := j + 1;
		pool
		i := i + 1;
		j := 0;
	pool
};