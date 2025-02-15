#include <stdio.h>

// Declaring the external Assembly functions
extern int add(int a, int b);
extern int subtract(int a, int b);
extern int multiply(int a, int b);
extern int divide(int a, int b);

int main() {
    int choice, a, b, result, remainder, quotient;

    while (1) {
        // Display the menu
        printf("Calculator Menu:\n");
        printf("1. Add\n");
        printf("2. Subtract\n");
        printf("3. Multiply\n");
        printf("4. Divide\n");
        printf("5. Exit\n");
        printf("Select an option (1-5): ");
        scanf("%d", &choice);

        if (choice == 5) {
            break; // Exit the loop if the user selects 5
        }
        
        else if (choice > 5) {
			printf("Invalid choice, choose between 1 and 5\n");
			break;
		};

        // Ask for input numbers
        printf("Enter 1st integer: ");
        scanf("%d", &a);
        printf("Enter 2nd integer: ");
        scanf("%d", &b);


        // Perform the chosen operation
        switch (choice) {
        case 1:
            result = add(a, b);
            printf("Result: %d\n", result);
            break;
        case 2:
            result = subtract(a, b);
            printf("Result: %d\n", result);
            break;
        case 3:
            result = multiply(a, b);
            printf("Result: %d\n", result);
            break;
		case 4:
            if (b == 0) {
                printf("Error: Division by zero is not allowed.\n");
            }
            else {
                quotient = divide(a, b);
                asm("mov %0, r1" : "=r"(remainder)); //I moved the value from r0 directly to  the 'remainder' variable
                printf("Result:\n", result);
                printf("Quotient: %d, Remainder: %d\n", quotient, remainder);                
            }
            break;
		};
    
    printf("\n");
    return 0;
}	

}
