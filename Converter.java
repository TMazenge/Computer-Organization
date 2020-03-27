/***********************
 * 
 * This program reads an integer and a double number from the console and 
 * converts them to binary numbers. The binary numbers are of string type.
 * 
 */
//package NumberConverter;

import java.util.Scanner;

public class Converter {
	public static final int DecimalDigits = 10; // number of binary digits  
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		
		// This code test interger conversion
		System.out.println("Please enter a decimal integer number:");
		int input = scan.nextInt();

		System.out.print(input);
		System.out.print("(Dec) = ");
		System.out.print(dec2binInt(input));
		System.out.println("(Bin)");

		// This code test float conversion
		System.out.println("Please enter a decimal real number:");
		double inputD = scan.nextDouble();

		System.out.print(inputD);
		System.out.print("(Dec) = ");
		input = (int) inputD;
		
		System.out.print(dec2binInt(input));
		System.out.print(dec2binDouble(inputD-input));
		System.out.println("(Bin)");

	}

	public static String dec2binInt(int input) {
		String result = "";
		
		int rem = input % 2;
		while (input > 0) {
			rem = input % 2;
			if (rem > 0){
				input = (input - 1) / 2;
				result = "1" + result;
			} else {
				input = input / 2;
				result = "0" + result;
			}
		}
		return result;
	}
	
	public static String dec2binDouble(double input) {
		String result = ".";
		int length = 0;

		while (input > 0 && length <= 11){
			input = input * 2;
			if (input >= 1.0) {
				input = input - 1;
				result = result + "1";	
			} else {
				result = result + "0";
			}
			length += 1;
		}
		return result;
	}
}
