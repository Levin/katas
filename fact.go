package main;

import (
		"fmt"
		"strconv"
)


func main()  {

		var str_number string;
		_, err := fmt.Scanln(&str_number)
		if err != nil {
				fmt.Println("error reading ...")
				return 
		}

		var number int 
		val, err := strconv.Atoi(str_number)
		if err != nil {
				fmt.Println("error reading ...")
				return 
		}
		number = val;

		var result int = 1

		for i:=number; i > 0 ; i -- {
				result *= i
		}

		fmt.Println(result)


	
}
